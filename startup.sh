apt-get install gcc build-essential -y &
python3 -m pip install -r requirements.txt
gunicorn -w 4 -b 0.0.0.0:8000 app:app
