
from flask import Flask,render_template,request,redirect,url_for,Response
from werkzeug.utils import secure_filename
import text_detect
import os

app = Flask(__name__)




@app.route('/')
def hello_world():
      return 'Hello World!'

@app.route('/api/detect-image',methods = ['GET','POST'])
def detectText():
      file_name="Nothing.jpg"
      staticFilePath = 'static/output'
      if request.method=='POST':
        f = request.files["file"]
        base_path = os.path.abspath(os.path.dirname(__file__))
        upload_path = os.path.join(base_path,staticFilePath)
        if(os.path.exists(upload_path)==False):
              os.mkdir(upload_path)
        file_name = upload_path+'/' + secure_filename(f.filename)
        f.save(file_name)
        file_name =f.filename
        
      return render_template('image_uploader.html', path = file_name)
      
if __name__ == '__main__':
      app.run()