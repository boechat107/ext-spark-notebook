# Extended Jupyter Notebook

Dockerfile based on
[jupyter/all-spark-notebook](https://github.com/jupyter/docker-stacks/tree/master/all-spark-notebook)
extended with
[jupyter-vim-binding](https://github.com/lambdalisue/jupyter-vim-binding).

Some features:

* Spark 1.6.0 with Python, Scala or R.
* Edit notebooks using Vim keybindings.
* JDBC driver for Postgres 9.4.

## Postgres driver usage

An example of usage in Python:

```python
import os
from pyspark import SparkContext
from pyspark.sql import SQLContext

sc = SparkContext("local[*]")
sqlsc = SQLContext(sc)

jdbcOpts = {'url' : 'jdbc:postgresql://localhost:5432/postgres',
            'driver' : 'org.postgresql.Driver',  
            'user' : 'postgres', 
            'password' : 'postgres'
           }

df = sqlsc.read.jdbc(
    url = jdbcOpts["url"],
    ## This query is executed in the database.
    table = '(select * from SOME_TABLE limit 1000) as table',
    properties = jdbcOpts
)

df.describe().show()
```
