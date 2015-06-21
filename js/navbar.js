function heredoc(fn) {
    return fn.toString().split('\n').slice(1,-1).join('\n') + '\n'
}

var navCode = heredoc(function(){/*
<nav class="navbar navbar-inverse navbar-fixed-top" style="">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" style="padding-top: 12px;" href="https://www.daocloud.io/">
      <img width="80%" src="/img/ae0160df.logo-white-small.png"/>
      </a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-9">
      <ul class="nav navbar-nav">
        <li><a href="http://help.daocloud.io/" style="font-size:18px">文档</a></li>
        <li><a href="http://open.daocloud.io/" style="font-size:18px">社区</a></li>
        <li><a href="https://dashboard.daocloud.io/" style="font-size:18px">控制台</a></li>
      </ul>
    </div>
  </div>
</nav>
*/});

var newNode = document.createElement("div");
newNode.innerHTML = navCode;
$('body')[0].insertBefore(newNode,$('body')[0].firstChild);
document.body.style['padding-top']='50px';
