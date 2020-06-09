const express =require('express');
const morgan = require('morgan');
const exphbs = require("express-handlebars");
const path = require('path');
const flash = require("connect-flash");
const session = require("express-session");
const MySQLSore = require('express-mysql-session');
const { database } =  require('./keys');



//initializations
const app = express();

//setting
app.set("port", process.env.PORT || 4000);
app.set("views", path.join(__dirname, "views"));
app.engine(
  ".hbs",
  exphbs({
    defaultLayout: "main",
    layoutsDir: path.join(app.get("views"), "layouts"),
    partialsDir: path.join(app.get("views"), "partials"),
    extname: ".hbs",
    helpers: require("./lib/handlebars")
  })
);
app.set("view engine", ".hbs");


//middleware
app.use(session({
  secret:'covid_session',
  resave: false,
  saveUninitialized: false,
  store: MySQLSore(database)
}))
app.use(flash());
app.use(morgan('dev'));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

//global variables
app.use((req, res, next) => {
  app.locals.success = req.flash("success");
  next();
});

//routes
app.use(require("./routes"));
app.use(require("./routes/authentication"));
app.use("/persona", require("./routes/persona"));


//public
app.use(express.static(path.join(__dirname, "public")));

//starting the server
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
})