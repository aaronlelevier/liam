# liam

Use python `boto3.client` API with Erlang

## Setup

### Erlang

Install `rebar3`

### Python

For the Python flask app [boto3_flask](https://github.com/aaronlelevier/boto3_flask)
dependency, git clone the linked repo and set the environment variable:

```shell script
export LIAM_BOTO3_FLASK_DIR=path/to/boto3_flask
```

Install `boto3_flask` by following the project's `README.md` 

## Workflow

Can start and stop Flask server using Erlang by doing the following.

Terminal 1 (Erlang)

```bash
$ rebar3 shell

% start
1> {ok, Pid} = liam_gs_boto3_server:start_link().

% can now make http calls to in other shell

% stop
2> gen_server:stop(Pid).  
```

Terminal 2 (Shell)

```bash
% list running processes on port
lsof -i :5000 | awk 'NR > 1 {print $2}' 

# make example API call
curl http://localhost:5000/s3/list_buckets
```
