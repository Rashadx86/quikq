# quikq

### Description 
Node-centric squeue output for slurm queues. Sort and categorize jobs based on node placement, and job status.

Mimics GridEngine's "qstat" and includes summary reporting (eg. # of jobs running or pending, allocated cores/ram, etc)

### Sample Output

```
             JOBID     PRIORITY PARTITION     NAME     USER    STATE       TIME  TIME_LIMIT   CPUS       GRES  NODES            SUBMIT_TIME MIN_ME  NODELIST(REASON)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
           5187566 0.0521496420     gen_cpu matlab2x  user1    RUNNING 1-19:45:17  5-00:00:00      1     (null)      1    2020-06-23T11:24:59    50G  node001
           5187567 0.0521493686     gen_cpu 12345678  user2    RUNNING 1-19:45:17  5-00:00:00      1     (null)      1    2020-06-23T11:26:10    50G  node001
           5189019 0.0000232830     gen_cpu     bash  user3    RUNNING   22:55:58  7-00:00:00      1     (null)      1    2020-06-24T08:33:41     8G  node001
------------------------------------------------------------------------------------------------------------------------------------------------------------------
           5184491 0.1244741599     gen_cpu download  usera    RUNNING 4-20:23:24  7-00:00:00      4     (null)      1    2020-06-20T11:06:51  8000M  node002
           5187351 0.1287745272     gen_cpu     bash  userb    RUNNING 2-10:50:39  7-00:00:00      1     (null)      1    2020-06-22T20:39:23     8G  node002
           5187519 0.0000939485     gen_cpu example1  userc    RUNNING 1-15:47:38  4-04:00:00      8     (null)      1    2020-06-23T10:35:38    64G  node002
           5187533 0.0000908880     gen_cpu example2  userd    RUNNING 1-15:54:52  4-04:00:00      8     (null)      1    2020-06-23T10:38:53    30G  node002
------------------------------------------------------------------------------------------------------------------------------------------------------------------
           5185170 0.0009075815     gen_cpu example3  userx    RUNNING   22:20:16  2-12:02:00     16     (null)      1    2020-06-21T17:18:09    90G  node003
           5190048 0.0040140466     gen_cpu example4  usery    RUNNING    8:24:57    12:00:00      1     (null)      1    2020-06-24T23:04:48    16G  node003
------------------------------------------------------------------------------------------------------------------------------------------------------------------
           5185185 0.0011836020     gen_cpu example5  userz    RUNNING    2:26:59  2-12:02:00     16     (null)      1    2020-06-21T17:18:11    90G  node004

...

###############################################################################-  QUEUE  -###############################################################################

             JOBID     PRIORITY PARTITION     NAME     USER    STATE       TIME  TIME_LIMIT   CPUS       GRES  NODES            SUBMIT_TIME MIN_ME  NODELIST(REASON)
           5184707 0.2054899966     gen_cpu examplea  usera    PENDING       0:00  6-06:00:00      1     (null)      1    2020-06-20T18:35:01   500G  (Resources)
           5184708 0.2054899773     gen_cpu exampleb  userb    PENDING       0:00  6-06:00:00      1     (null)      1    2020-06-20T18:35:06   500G  (Priority)
           5187552 0.0006435567     gen_cpu examplec  userc    PENDING       0:00  4-04:00:00     21     (null)      1    2020-06-23T10:41:13   192G  (Priority)
           5187553 0.0006435220     gen_cpu exampled  userd    PENDING       0:00  4-04:00:00     21     (null)      1    2020-06-23T10:41:22   192G  (Priority)
           5184432 0.0005026531     gen_cpu exampleh  user4    PENDING       0:00  2-12:02:00     16     (null)      1    2020-06-23T20:49:13    90G  (Priority)

...

-------------------------------
Running jobs:              862
Pending jobs:              2970
Users with running jobs:   22
Cores allocated:           1604
RAM allocated:             19656 GB

```

### Usage

`bash quikq/quikq.sh`

##### To display GRES:

`bash quikq/quikq_gpu.sh`
