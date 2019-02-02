from flask import Flask
from flask import render_template
from flask import request
from flask import json
#from flask.ext.mysql import MySQL
from flaskext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash
#from flask_bootstrap import Bootstrap

app = Flask(__name__)
#Bootstrap(app)
#app.config['BOOTSTRAP_SERVE_LOCAL'] = True #This turns file serving static

mysql = MySQL()
 
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'BucketList'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)


@app.route("/")
def main():
	##return "Welcome!"
	return render_template('index.html')

@app.route('/showSignUp')
def showSignUp():
    return render_template('signup.html')

@app.route('/signUp', methods=['POST'])
def signUp():
    # this function interacts with MySQL database!!
    # Get values submitted from UI
    _name = request.form['inputName']
    _email = request.form['inputEmail']
    _password = request.form['inputPassword']

    # validate the received values
    if _name and _email and _password:
        #return json.dumps({'html':'<span>All fields good !!</span>'})
        conn = mysql.connect()
        cursor = conn.cursor()
        _hashed_password = generate_password_hash(_password)
        cursor.callproc('sp_createUser',(_name,_email,_hashed_password))
        data = cursor.fetchall()
        if len(data) is 0:
        	conn.commit()
        	return json.dumps({'message':'User created successfully !'})
        else:
        	return json.dumps({'error':str(data[0])})

    else:
        return json.dumps({'html':'<span>Enter the required fields</span>'})

if __name__ == "__main__":
	app.run()