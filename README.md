## Environment Runner

Run what your want if env variable and same name script exist, easy to scale, simplify bootstrap pipelines

Tired of writing scripts to start servers? 🫠

Do you want to be able to easily manage the process so that you can disable some scripts from the general script at any time? 🥰

#### Two easy steps:

- Create .sh script and drop at runner folder
- Export ENV by template RUNNER_NAME_OF_SCRIPT_UPPERCASE=1

Demo
-

![Demo gif](https://raw.githubusercontent.com/bigpe/EnvironmentRunner/master/demo.gif)

Simple example (if it's still not clear)
-

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
