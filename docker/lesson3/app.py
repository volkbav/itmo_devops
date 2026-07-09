from flask import Flask
from redis import Redis
import socket

# print(socket.gethostname())
app = Flask(__name__)
db = Redis (host="redis")
host = socket.gethostname()

@app.route("/")
def hello():
    visitsCounter = db.incr('visitsCounter')
    html = "<H1> Hello! </H1>" \
	"<b>Visits: </b>{visits}"\
	"<br>"\
	"<b>Host: </b>{host}"\
	"</br>" \
    "new" \
    "</br>"

    return html.format(visits=visitsCounter, host=host)

if __name__=="__main__":
    app.run(host="0.0.0.0",port=80)

