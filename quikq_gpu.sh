#!/bin/bash

# Mimic qstat output for slurm queues & added column for gres
# To customize, update variables below

export queue_loc="/$HOME/queue" #where to write temporary squeue output for parsing.
export partition="--partition=all"
export squeue_options='%.24i %.12p %.9P %.8j %.8u %.8T %.10M %.11l %.6C %.6D %.6b %.22V %.6m  %R'
export dashes=$(printf '%.s-' {1..167})
export queue_line=$(printf '%.s#' {1..76} && printf -- "-  QUEUE  -" && printf '%.s#' {1..76})
export state_column=6 #column where job state is defined (squeue -o %T)
export priority_column=2 #column where priority is defined (squeue -o %p)

#Variables needed for summary reporting
export total_columns=14
export users_column=5 #column where user is defined (squeue -o %u)
export cores_column=9 #column where core count is defined (squeue -o %C)
export memory_column=13 #column where memory is defined (squeue -o %m)



# Anything below shouldn't need to be modified

function squeue_cmd {
        squeue -o "$squeue_options" $partition
                }

#Run squeue, sort by last field (nodename)
squeue_cmd | sort -k $total_columns > $queue_loc


#Print running jobs
        awk -v dashes="$dashes" '{ c=$NF; if(c!=p && NR>1) { print dashes } print ; p=c ; } ' $queue_loc |
        awk -v column="$state_column" '$column!="PENDING"' |
        grep -v PARTITION |
        sed '$!N; /^\(.*\)\n\1$/!P; D'

#Print queue separator line
        echo -e "\n$queue_line\n"

#Print pending jobs, sort by priority.
        awk -v column="$state_column" '$column!="RUNNING"' $queue_loc |
        sort -rk $priority_column


# Summary reporting

running_jobs=$(awk -v column="$state_column" '$column=="RUNNING" { ++count} END {print count}' $queue_loc)
pending_jobs=$(awk -v column="$state_column" '$column=="PENDING" { ++count} END {print count}' $queue_loc)
uniq_users=$(awk -v column="$state_column" '$column=="RUNNING"' $queue_loc | 
        awk -v column="$users_column" '{print $column}' | 
        awk '!a[$0]++' | 
        awk 'END{print NR}' )

running_cores=$(awk -v column="$state_column" '$column=="RUNNING"' $queue_loc | 
        awk -v column="$cores_column" '{print $column}' | 
        awk '{s+=$1} END {print s}')

mem_in_use=$(awk -v column="$state_column" '$column=="RUNNING"' $queue_loc |
        awk -v column="$memory_column" '$column ~ /[0-9\.]+M/ { $column = int($column / 1000) } 1' |
        awk -v column="$memory_column" '$column ~ /[0-9\.]+G/ { $column = int($column / 1) } 1' | 
        awk -v column="$memory_column" '{print $column}' | 
        grep -Eo '[0-9]{1,}' | 
        paste -sd+ - | 
        bc )



echo -e "\n-------------------------------"

printf "Running jobs:              %s\n" $running_jobs
printf "Pending jobs:              %s\n" $pending_jobs
printf "Users with running jobs:   %s\n" $uniq_users
printf "Cores allocated:           %s\n" $running_cores
printf "RAM allocated:             %s GB\n\n" $mem_in_use

rm -rf $queue_loc

