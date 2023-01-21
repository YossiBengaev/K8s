from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route('/')
def html_table():
    return render_template('index.html')

#if __name__ == "__main__":
    #app.run(debug=True)
    
app.run(host='0.0.0.0', port=5000)