var handlebars = require("handlebars");
handlebars.registerHelper("moment", require("helper-moment"));

handlebars.registerHelper('tiene', function (value) {
    return value == 1;
  });