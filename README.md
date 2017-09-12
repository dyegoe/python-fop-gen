# python-fop-gen

This python is used to read [SNEP](http://snep.com.br/en/) database and generate a [FOP2](https://www.fop2.com/) config.

Its generate a fop2.cfg and buttons.cfg based on a Jinja2 template.

## Logic behind the scenes

To auto generate the config, the script read the database and create a buttons with ALL extensions associated with a callgroup.

The script use the callgroup description to generate a group admin. So, to create an admin to a group you should put in the callgroup description something like this: `Group1 5555`. Where `5555` is the admin extension and it will be used as an interface user and twice for a password.