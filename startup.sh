#!/bin/sh

echo 'export APP_PATH="/home/site/wwwroot"' >> ~/.bashrc
echo 'cd $APP_PATH' >> ~/.bashrc

# Enter the source directory to make sure the script runs where the user expects
cd /home/site/wwwroot

export APP_PATH="/home/site/wwwroot"
if [ -z "$HOST" ]; then
                export HOST=0.0.0.0
fi

if [ -z "$PORT" ]; then
                export PORT=80
fi

export PATH="/opt/python/3.8.6/bin:${PATH}"
echo 'export VIRTUALENVIRONMENT_PATH="/home/site/wwwroot/pythonenv3.8"' >> ~/.bashrc
echo '. pythonenv3.8/bin/activate' >> ~/.bashrc
PYTHON_VERSION=$(python -c "import sys; print(str(sys.version_info.major) + '.' + str(sys.version_info.minor))")
echo Using packages from virtual environment 'pythonenv3.8' located at '/home/site/wwwroot/pythonenv3.8'.
export PYTHONPATH=$PYTHONPATH:"/home/site/wwwroot/pythonenv3.8/lib/python$PYTHON_VERSION/site-packages"
echo "Updated PYTHONPATH to '$PYTHONPATH'"
mkdir -p /github/workspace
ln -sf /home/site/wwwroot/pythonenv3.8 /github/workspace
. pythonenv3.8/bin/activate
GUNICORN_CMD_ARGS="--timeout 600 --access-logfile '-' --error-logfile '-' --chdir=/home/site/wwwroot" gunicorn app:app
