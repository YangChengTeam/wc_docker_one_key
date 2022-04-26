

const spawn = require('child_process').spawn;


// 开启守护进程 
function startDaemon() {
    const daemon = spawn('node', ['pulsarMaster.js'], {
        detached: true,
        stdio: 'ignore',
        windowsHide:true
    });

    console.log('守护进程开启 父进程 pid: %s, 守护进程 pid: %s', process.pid, daemon.pid);
    daemon.unref();

}

startDaemon()