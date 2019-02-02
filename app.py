from flask import Flask
from flask import render_template
#from flask_bootstrap import Bootstrap

app = Flask(__name__)
#Bootstrap(app)
#app.config['BOOTSTRAP_SERVE_LOCAL'] = True #This turns file serving static

@app.route("/")
def main():
	##return "Welcome!"
	return render_template('index.html')

if __name__ == "__main__":
	app.run()