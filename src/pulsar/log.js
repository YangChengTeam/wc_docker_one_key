
const fs = require('fs')


let options = {
    flags: 'a', // 
    encoding: 'utf8', // utf8编码
}

//2022-02-13_err.log
let fileName = getFullDate() + "_err.log" //log日志的文件名

let stderr = fs.createWriteStream('./' + fileName, options);

// 创建logger
let logger = new console.Console(stderr);

// fs.writeFile('./' + fileName, '\n', function (err) {
//     if (err) {
//         console.log(err);
//     }
// });

function log(msg) {
    let time = getFullTime()
    logger.log(time + "： " + msg + "\r\n------------------------------------------------------------------------------\r\n")
}


function error(msg) {
    let time = getFullTime()
    logger.error(time + "：" + msg + "\r\n------------------------------------------------------------------------------\r\n")
}



// 年月日
function getFullDate() {
    let date = new Date(),//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        Y = date.getFullYear() + '',
        M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1),
        D = (date.getDate() < 10 ? '0' + (date.getDate()) : date.getDate())
    return Y + "-" + M + '-' + D
}

// 年月日，时分秒
function getFullTime() {
    let date = new Date(),//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        Y = date.getFullYear() + '',
        M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1),
        D = (date.getDate() < 10 ? '0' + (date.getDate()) : date.getDate()),
        h = (date.getHours() < 10 ? '0' + (date.getHours()) : date.getHours()),
        m = (date.getMinutes() < 10 ? '0' + (date.getMinutes()) : date.getMinutes()),
        s = (date.getSeconds() < 10 ? '0' + (date.getSeconds()) : date.getSeconds());
    return Y + "-" + M + '-' + D + ' ' + h + ':' + m + ':' + s
}
module.exports = {
    log: log,
    error: error
}