## Environment Runner

#### Run what your want if ENV and same SCRIPT exist, easy to scale, simplify bootstrap pipelines

![Demo gif](https://raw.githubusercontent.com/bigpe/EnvironmentRunner/master/demo.gif)

You want to execute do_something.sh, e.g. before server started

```shell
export RUNNER_DO_SOMETHING=1

./runner.sh
```

To disable runner for script just unset or set value to 0

```shell
export RUNNER_DO_SOMETHING=0
```
```shell
unset RUNNER_DO_SOMETHING
```
