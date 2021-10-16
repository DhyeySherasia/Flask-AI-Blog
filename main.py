from flask import Flask, render_template, request, session, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_mail import Mail
import json
import os
import math
from werkzeug.utils import secure_filename

with open("config.json", "r") as f:
    params = json.load(f)["params"]

local_server = params['local_server']

app = Flask(__name__)
app.secret_key = "secret key"
app.config['Upload Files'] = params['upload_location']

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail_username'],
    MAIL_PASSWORD=params['gmail_password']
)
mail = Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["production_uri"]

db = SQLAlchemy(app)


# nullable = False --> Required field
class Contacts(db.Model):
    srno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    email = db.Column(db.String(20), unique=False, nullable=False)
    phone_number = db.Column(db.String(12), unique=False, nullable=False)
    mssg = db.Column(db.String(120), unique=False, nullable=False)
    date = db.Column(db.String(12), unique=False, nullable=True)


class Posts(db.Model):
    srno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(30), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    image = db.Column(db.String(30), nullable=True)


@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    # [0:params['n_posts_homepage']]
    last_page = math.ceil(len(posts) / int(params['n_posts_homepage']))
    page = request.args.get('page')
    if not str(page).isnumeric():
        page = 1

    page = int(page)
    posts = posts[(page-1) * int(params['n_posts_homepage']):(page-1) * int(params['n_posts_homepage']) + int(params['n_posts_homepage'])]

    # First
    if page == 1:
        prev = "#"
        next = "/?page=" + str(page + 1)

    # Last
    elif page == last_page:
        prev = "/?page=" + str(page - 1)
        next = "#"

    # Middle
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)

    return render_template("index.html", params=params, posts=posts, prev=prev, next=next)


# User clicked a post. Send its slug in url. Find post from database using that slug
@app.route("/post/<string:post_slug>", methods=["GET"])
def post(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()  # Fetch first if have same slug

    return render_template("post.html", params=params, post=post)


@app.route("/about")
def about():
    return render_template("about.html", params=params)


@app.route("/dashboard", methods=["GET", "POST"])
def dashboard():
    # If already logged in, give direct access
    if 'user' in session and session['user'] == params['admin_username']:
        posts = Posts.query.all()
        return render_template("dashboard.html", params=params, username=params['admin_username'], posts=posts)

    if request.method == "POST":
        # Redirect to Admin Panel
        username = request.form.get('username')
        userpass = request.form.get('password')
        if username == params['admin_username'] and userpass == params['admin_pass']:
            # Set the session variable
            session['user'] = username
            posts = Posts.query.all()
            return render_template("dashboard.html", params=params, username=params['admin_username'], posts=posts)

    # Redirect to the same login page
    return render_template("login.html", params=params)


@app.route("/edit/<string:srno>", methods=["GET", "POST"])
def edit(srno):
    if 'user' in session and session['user'] == params['admin_username']:
        # If submitting form
        if request.method == 'POST':
            req_title = request.form.get('title')
            req_tagline = request.form.get('tagline')
            req_slug = request.form.get('slug')
            req_content = request.form.get('content')
            req_img_file = request.form.get('img_file')
            date = datetime.now()

            if srno == '0':
                post = Posts(title=req_title, slug=req_slug, content=req_content, tagline=req_tagline,
                             image=req_img_file, date=date)
                db.session.add(post)
                db.session.commit()

            else:
                # Fetch the post with that srno
                post = Posts.query.filter_by(srno=srno).first()
                # Update details
                post.title = req_title
                post.tagline = req_tagline
                post.slug = req_slug
                post.content = req_content
                post.image = req_img_file
                post.date = date

                db.session.commit()

                # This time method would not be POST. Hence will render edit.html file
                return redirect('/edit/' + srno)

        post = Posts.query.filter_by(srno=srno).first()
        # If not submitted form (method not POST) then render the form
        return render_template("edit.html", username=params['admin_username'], srno=srno, post=post, params=params)


@app.route("/uploader", methods=["GET", "POST"])
def uploader():
    if 'user' in session and session['user'] == params['admin_username']:
        if request.method == "POST":
            f = request.files['new_file']
            f.save(os.path.join(app.config['Upload Files'], secure_filename(f.filename)))
            print(f.filename)

            return redirect('/dashboard')


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect("/")


@app.route("/delete/<string:srno>")
def delete(srno):
    if 'user' in session and session['user'] == params['admin_username']:
        post = Posts.query.filter_by(srno=srno).first()
        db.session.delete(post)
        db.session.commit()

        return redirect("/dashboard")


@app.route("/contact", methods=["GET", "POST"])
def contact():
    if request.method == "POST":
        # Add entry to the database

        # fetching data from website's contact form
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        date = datetime.now()

        # database_attribute = fetched_from_user
        contacts_entry = Contacts(name=name, email=email, mssg=message, phone_number=phone, date=date)

        db.session.add(contacts_entry)
        db.session.commit()

        mail.send_message("You have a new message from " + name + " on your Blog",
                          sender=email,
                          recipients=['dhyeysherasia2002@gmail.com'],
                          body="Message: \n" + message + '\n' + "\nContact No.: " + phone)

    return render_template("contact.html", params=params)


app.run(debug=True)
