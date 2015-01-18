var BaseController = require('./Base'),
    userService = new (require('../service/UserService'))(),
    sessionService = new (require('../service/SessionService'))(),
    crypto = require('crypto');

var CRYPTO_SALT = "myfolio";

function UserController() {
    if(!(this instanceof UserController)) {
        return new UserController();
    }
}

UserController.prototype = new BaseController('UserController');

UserController.prototype.getUsers = function(req, res, next) {
    var params = {};

    userService.getUsers(params, function(err, result){
        if (err) {
            res.status(404).send(err);
            return;
        }
        res.status(200).send(result);
    });
};

UserController.prototype.join = function(req, res, next) {
    var params = {
        id: req.body.id,
        pw: crypto.createHmac('sha1', CRYPTO_SALT).update(req.body.pw).digest('hex'),
        name: req.body.name
    };

    userService.joinUser(params, function(err, result){
        if (err) {
            res.status(404).send(err);
            return;
        }
        sessionService.registerSession(req, params.id, params.name);//session을 등록
        res.status(200).send(result);
    });
};

UserController.prototype.login = function(req, res, next) {
    var params = {
        id: req.body.id,
        pw: crypto.createHmac('sha1', CRYPTO_SALT).update(req.body.pw).digest('hex')
    };

    userService.loginUser(params, function(err, result){
        if (err) {
            res.status(404).send(err);
            return;
        }
        console.log('controller result : ',result);
        if(result.code==1){
            sessionService.registerSession(req,params.id,result.userName);//session을 등록
        }
        res.status(200).send(result);
    });
};

UserController.prototype.logout = function(req,res,next){
    sessionService.removeSession(req);
    res.status(200).send();
};

module.exports = UserController;


