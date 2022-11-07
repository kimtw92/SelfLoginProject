//==========================================================================
// Lib
//==========================================================================

var kitmc_NS4 = (navigator.appName.indexOf("Netscape") >= 0 &&
                parseFloat(navigator.appVersion) >= 4) ? 1 : 0;
var isMinIE4 = (document.all) ? 1 : 0;
var isMinIE5 = (isMinIE4 && navigator.appVersion.indexOf("5.")) >= 0 ? 1 : 0;

function hideLayer(layer) {

  if (kitmc_NS4)
    layer.visibility = "hide";
  if (isMinIE4)
    layer.style.visibility = "hidden";
}

function showLayer(layer) {

  if (kitmc_NS4)
    layer.visibility = "show";
  if (isMinIE4)
    layer.style.visibility = "visible";
}

function isVisible(layer) {

  if (kitmc_NS4 && layer.visibility == "show")
    return(true);
  if (isMinIE4 && layer.style.visibility == "visible")
    return(true);

  return(false);
}


function moveLayerTo(layer, x, y) {

  if (kitmc_NS4)
    layer.moveTo(x, y);
  if (isMinIE4) {
    layer.style.left = x;
    layer.style.top  = y;
  }
}

function moveLayerBy(layer, dx, dy) {

  if (kitmc_NS4)
    layer.moveBy(dx, dy);
  if (isMinIE4) {
    layer.style.pixelLeft += dx;
    layer.style.pixelTop  += dy;
  }
}

function getLeft(layer) {

  if (kitmc_NS4)
    return(layer.left);
  if (isMinIE4)
    return(layer.style.pixelLeft);
  return(-1);
}

function getTop(layer) {

  if (kitmc_NS4)
    return(layer.top);
  if (isMinIE4)
    return(layer.style.pixelTop);
  return(-1);
}

function getRight(layer) {

  if (kitmc_NS4)
    return(layer.left + getWidth(layer));
  if (isMinIE4)
    return(layer.style.pixelLeft + getWidth(layer));
  return(-1);
}

function getBottom(layer) {

  if (kitmc_NS4)
    return(layer.top + getHeight(layer));
  else if (isMinIE4)
    return(layer.style.pixelTop + getHeight(layer));
  return(-1);
}

function getPageLeft(layer) {

  if (kitmc_NS4)
    return(layer.pageX);
  if (isMinIE4)
    return(layer.offsetLeft);
  return(-1);
}

function getPageTop(layer) {

  if (kitmc_NS4)
    return(layer.pageY);
  if (isMinIE4)
    return(layer.offsetTop);
  return(-1);
}

function getWidth(layer) {

  if (kitmc_NS4) {
    if (layer.document.width)
      return(layer.document.width);
    else
      return(layer.clip.right - layer.clip.left);
  }
  if (isMinIE4) {
    if (layer.style.pixelWidth)
      return(layer.style.pixelWidth);
    else
      return(layer.clientWidth);
  }
  return(-1);
}

function getHeight(layer) {

  if (kitmc_NS4) {
    if (layer.document.height)
      return(layer.document.height);
    else
      return(layer.clip.bottom - layer.clip.top);
  }
  if (isMinIE4) {
    if (false && layer.style.pixelHeight)
      return(layer.style.pixelHeight);
    else
      return(layer.clientHeight);
  }
  return(-1);
}

function getzIndex(layer) {

  if (kitmc_NS4)
    return(layer.zIndex);
  if (isMinIE4)
    return(layer.style.zIndex);

  return(-1);
}

function setzIndex(layer, z) {

  if (kitmc_NS4)
    layer.zIndex = z;
  if (isMinIE4)
    layer.style.zIndex = z;
}


function clipLayer(layer, clipleft, cliptop, clipright, clipbottom) {

  if (kitmc_NS4) {
    layer.clip.left   = clipleft;
    layer.clip.top    = cliptop;
    layer.clip.right  = clipright;
    layer.clip.bottom = clipbottom;
  }
  if (isMinIE4)
    layer.style.clip = 'rect(' + cliptop + ' ' +  clipright + ' ' + clipbottom + ' ' + clipleft +')';
}

function getClipLeft(layer) {

  if (kitmc_NS4)
    return(layer.clip.left);
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return(0);
    var clip = getIEClipValues(layer.style.clip);
    return(clip[3]);
  }
  return(-1);
}

function getClipTop(layer) {

  if (kitmc_NS4)
    return(layer.clip.top);
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return(0);
    var clip = getIEClipValues(layer.style.clip);
    return(clip[0]);
  }
  return(-1);
}

function getClipRight(layer) {

  if (kitmc_NS4)
    return(layer.clip.right);
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return(layer.style.pixelWidth);
    var clip = getIEClipValues(layer.style.clip);
    return(clip[1]);
  }
  return(-1);
}

function getClipBottom(layer) {

  if (kitmc_NS4)
    return(layer.clip.bottom);
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return(layer.style.pixelHeight);
    var clip = getIEClipValues(layer.style.clip);
    return(clip[2]);
  }
  return(-1);
}

function getClipWidth(layer) {

  if (kitmc_NS4)
    return(layer.clip.width);
  if (isMinIE4) {
    var str = layer.style.clip;
    if (!str)
      return(layer.style.pixelWidth);
    var clip = getIEClipValues(layer.style.clip);
    return(clip[1] - clip[3]);
  }
  return(-1);
}

function getClipHeight(layer) {

  if (kitmc_NS4)
    return(layer.clip.height);
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return(layer.style.pixelHeight);
    var clip = getIEClipValues(layer.style.clip);
    return(clip[2] - clip[0]);
  }
  return(-1);
}

function getIEClipValues(str) {

  var clip = new Array();
  var i;

 

  i = str.indexOf("(");
  clip[0] = parseInt(str.substring(i + 1, str.length), 10);
  i = str.indexOf(" ", i + 1);
  clip[1] = parseInt(str.substring(i + 1, str.length), 10);
  i = str.indexOf(" ", i + 1);
  clip[2] = parseInt(str.substring(i + 1, str.length), 10);
  i = str.indexOf(" ", i + 1);
  clip[3] = parseInt(str.substring(i + 1, str.length), 10);
  return(clip);
}


function scrollLayerTo(layer, x, y, bound) {

  var dx = getClipLeft(layer) - x;
  var dy = getClipTop(layer) - y;

  scrollLayerBy(layer, -dx, -dy, bound);
}

function scrollLayerBy(layer, dx, dy, bound) {

  var cl = getClipLeft(layer);
  var ct = getClipTop(layer);
  var cr = getClipRight(layer);
  var cb = getClipBottom(layer);

  if (bound) {
    if (cl + dx < 0)

      dx = -cl;

    else if (cr + dx > getWidth(layer))
      dx = getWidth(layer) - cr;
    if (ct + dy < 0)

      dy = -ct;

    else if (cb + dy > getHeight(layer))
      dy = getHeight(layer) - cb;
  }

  clipLayer(layer, cl + dx, ct + dy, cr + dx, cb + dy);
  moveLayerBy(layer, -dx, -dy);
}

function setBgColor(layer, color) {

  if (kitmc_NS4)
    layer.bgColor = color;
  if (isMinIE4)
    layer.style.backgroundColor = color;
}

function setBgImage(layer, src) {

  if (kitmc_NS4)
    layer.background.src = src;
  if (isMinIE4)
    layer.style.backgroundImage = "url(" + src + ")";
}


function getLayer(name) {

  if (kitmc_NS4)
    return findLayer(name, document);
  if (isMinIE4)
    return eval('document.all.' + name);

  return null;
}

function findLayer(name, doc) {

  var i, layer;

  for (i = 0; i < doc.layers.length; i++) {
  
    layer = doc.layers[i];
    if (layer.name == name)
      return layer;
    if (layer.document.layers.length > 0) {
      layer = findLayer(name, layer.document);
      if (layer != null)
        return layer;
    }
  }

  return null;
}

function getWindowWidth() {

  if (kitmc_NS4)
    return(window.innerWidth);
  if (isMinIE4)
    return(document.body.clientWidth);
  return(-1);
}

function getWindowHeight() {

  if (kitmc_NS4)
    return(window.innerHeight);
  if (isMinIE4)
    return(document.body.clientHeight);
  return(-1);
}

function getPageWidth() {

  if (kitmc_NS4)
    return(document.width);
  if (isMinIE4)
    return(document.body.scrollWidth);
  return(-1);
}

function getPageHeight() {

  if (kitmc_NS4)
    return(document.height);
  if (isMinIE4)
    return(document.body.scrollHeight);
  return(-1);
}

function getPageScrollX() {

  if (kitmc_NS4)
    return(window.pageXOffset);
  if (isMinIE4)
    return(document.body.scrollLeft);
  return(-1);
}

function getPageScrollY() {

  if (kitmc_NS4)
    return(window.pageYOffset);
  if (isMinIE4)
    return(document.body.scrollTop);
  return(-1);
}

//==========================================================================
// Ticker
//==========================================================================
function calvin(x, y, width, height, border, padding) {

  this.items = new Array();
  this.created = false;




  this.setColors = kitmc_tickSetColors;
  this.setFont = kitmc_tickSetFont;
  this.setSpeed = kitmc_tickSetSpeed;
  this.setPause = kitmc_ticksetPause;
  this.addItem = kitmc_tickAddItem;
  this.create = kitmc_tickCreate;
  this.show = kitmc_tickShow;
  this.hide = kitmc_tickHide;
  this.moveTo = kitmc_tickMoveTo;
  this.moveBy = kitmc_tickMoveBy;
  this.getzIndex = kitmc_tickGetzIndex;
  this.setzIndex = kitmc_tickSetzIndex;
  this.stop = kitmc_tickStop;
  this.start = kitmc_tickStart;
}

function kitmc_ticker(x, y, width, height, border, padding) {

  this.x = x;
  this.y = y;
  this.width = width;
  this.height = height;
  this.border = border;
  this.padding = padding;

  this.items = new Array();
  this.created = false;



  this.fgColor = "#164854";
  this.bgColor = "#164854";
  this.bdColor = "#000000";



  this.fontFace = "굴림체";
  this.fontSize = "2";



  this.speed = 50;
  this.pauseTime = 3000;



  this.setColors = kitmc_tickSetColors;
  this.setFont = kitmc_tickSetFont;
  this.setSpeed = kitmc_tickSetSpeed;
  this.setPause = kitmc_ticksetPause;
  this.addItem = kitmc_tickAddItem;
  this.create = kitmc_tickCreate;
  this.show = kitmc_tickShow;
  this.hide = kitmc_tickHide;
  this.moveTo = kitmc_tickMoveTo;
  this.moveBy = kitmc_tickMoveBy;
  this.getzIndex = kitmc_tickGetzIndex;
  this.setzIndex = kitmc_tickSetzIndex;
  this.stop = kitmc_tickStop;
  this.start = kitmc_tickStart;
}


function kitmc_tickSetColors(fgcolor, bgcolor, bdcolor) {

  if (this.created) {
    alert("kitmc_ticker Error: kitmc_ticker has already been created.");
    return;
  }
  this.fgColor = fgcolor;
  this.bgColor = bgcolor;
  this.bdColor = bdcolor;
}

function kitmc_tickSetFont(face, size) {

  if (this.created) {
    alert("kitmc_ticker Error: kitmc_ticker has already been created.");
    return;
  }
  this.fontFace = face;
  this.fontSize = size;
}

function kitmc_tickSetSpeed(pps) {

  if (this.created) {
    alert("kitmc_ticker Error: kitmc_ticker has already been created.");
    return;
  }
  this.speed = pps;
}

function kitmc_ticksetPause(ms) {

  if (this.created) {
    alert("kitmc_ticker Error: kitmc_ticker has already been created.");
    return;
  }
  this.pauseTime = ms;
}

function kitmc_tickAddItem(str) {

  if (this.created) {
    alert("kitmc_ticker Error: kitmc_ticker has already been created.");
    return;
  }
  
  this.items[this.items.length] = str;
}

function kitmc_tickCreate() {

  var start, end;
  var str;
  var i, j;
  var x, y;

  if (!kitmc_NS4 && !isMinIE4)
    return;

  if (kitmc_tickList.length == 0)
 
    setInterval('kitmc_tickGo()', kitmc_tickInterval);


  if (this.created) {
    alert("kitmc_ticker Error: kitmc_ticker has already been created.");
    return;
  }


  this.created = true;


  this.items[this.items.length] = this.items[0];
  start = '<table border=0'
        + ' cellpadding=' + (this.padding + this.border)
        + ' cellspacing=0'
        + ' width=' + this.width
        + ' height=' + this.height + '>'
        + '<tr><td>'
        + '<font'
        + ' color="' + this.fgColor + '"'
        + ' face="' + this.fontFace + '"'
        + ' size=' + this.fontSize + '>';
  end   = '</font></td></tr></table>';


  if (kitmc_NS4) {
    this.baseLayer = new Layer(this.width);
    this.scrollLayer = new Layer(this.width, this.baseLayer);
    this.scrollLayer.visibility = "inherit";
    this.itemLayers = new Array();
    for (i = 0; i < this.items.length; i++) {
      this.itemLayers[i] = new Layer(this.width, this.scrollLayer);
      this.itemLayers[i].document.open();
      this.itemLayers[i].document.writeln(start + this.items[i] + end);
      this.itemLayers[i].document.close();
      this.itemLayers[i].visibility = "inherit";
    }

 

    setBgColor(this.baseLayer, this.bdColor);
    setBgColor(this.scrollLayer, this.bgColor);
  }

  if (isMinIE4) {
    i = kitmc_tickList.length;
    
    str = '<div id="kitmc_tick' + i + '_baseLayer"'
        + ' style="position:absolute;'
        + ' background-color:' + this.bdColor + ';'
        + ' width:' + this.width + 'px;'
        + ' height:' + this.height + 'px;'
        + ' overflow:hidden;'
        + ' visibility:hidden;">\n'
        + '<div id="kitmc_tick' + i + '_scrollLayer"'
        + ' style="position:absolute;'
        + ' background-color: ' + this.bgColor + ';'
        + ' width:' + this.width + 'px;'
        + ' height:' + (this.height * this.items.length) + 'px;'
        + ' visibility:inherit;">\n';
    for (j = 0; j < this.items.length; j++) {
      str += '<div id="kitmc_tick' + i + '_itemLayers' + j + '"'
          +  ' style="position:absolute;'
          +  ' width:' + this.width + 'px;'
          +  ' height:' + this.height + 'px;'
          +  ' visibility:inherit;">\n'
          +  start + this.items[j] + end
          +  '</div>\n';
     // j = j+1;    
    }
    str += '</div>\n'
        +  '</div>\n';


    if (!isMinIE5) {
      x = getPageScrollX();
      y = getPageScrollY();
      window.scrollTo(getPageWidth(), getPageHeight());
    }
    document.body.insertAdjacentHTML("beforeEnd", str);
    if (!isMinIE5)
      window.scrollTo(x, y);


    this.baseLayer = getLayer("kitmc_tick" + i + "_baseLayer");
    this.scrollLayer = getLayer("kitmc_tick" + i + "_scrollLayer");
    this.itemLayers = new Array();
    for (j = 0; j < this.items.length; j++)
      this.itemLayers[j] = getLayer("kitmc_tick" + i + "_itemLayers" + j);
  }


  moveLayerTo(this.baseLayer, this.x, this.y);
  clipLayer(this.baseLayer, 0, 0, this.width, this.height);
  moveLayerTo(this.scrollLayer, this.border, this.border);
  clipLayer(this.scrollLayer, 0, 0,
            this.width - 2 * this.border, this.height - 2 * this.border);


  x = 0;
  y = 0;
  for (i = 0; i < this.items.length; i++) {
    moveLayerTo(this.itemLayers[i], x, y);
    clipLayer(this.itemLayers[i], 0, 0, this.width, this.height);
    y += this.height;
   // i = i+1;
  }

  this.stopped = false;
  this.currentY = 0;
  this.stepY = this.speed / (1000 / kitmc_tickInterval);
  this.stepY = Math.min(this.height, this.stepY);
  this.nextY = this.height;
  this.maxY = this.height * (this.items.length - 1);
  this.paused = true;
  this.counter = 0;


  kitmc_tickList[kitmc_tickList.length] = this;


  showLayer(this.baseLayer);
}

function kitmc_tickShow() {

  if (this.created)
    showLayer(this.baseLayer);
}

function kitmc_tickHide() {

  if (this.created)
    hideLayer(this.baseLayer);
}

function kitmc_tickMoveTo(x, y) {

  if (this.created)
    moveLayerTo(this.baseLayer, x, y);
}

function kitmc_tickMoveBy(dx, dy) {

  if (this.created)
    moveLayerBy(this.baseLayer, dx, dy);
}

function kitmc_tickGetzIndex() {

  if (this.created)
    return(getzIndex(this.baseLayer));
  else
    return(0);
}

function kitmc_tickSetzIndex(z) {

  if (this.created)
    setzIndex(this.baseLayer, z);
}

function kitmc_tickStart() {

  this.stopped = false;
}

function kitmc_tickStop() {

  this.stopped = true;
}


var kitmc_tickList     = new Array();
var kitmc_tickInterval = 20;

function kitmc_tickGo() {

  var i;
 

  for (i = 0; i < kitmc_tickList.length; i++) {
	
    if (kitmc_tickList[i].stopped);

    else if (kitmc_tickList[i].paused) {
      kitmc_tickList[i].counter += kitmc_tickInterval;
      if (kitmc_tickList[i].counter > kitmc_tickList[i].pauseTime)
        kitmc_tickList[i].paused = false;
    }


    else {
      kitmc_tickList[i].currentY += kitmc_tickList[i].stepY;


      if (kitmc_tickList[i].currentY >= kitmc_tickList[i].nextY) {
        kitmc_tickList[i].paused = true;
        kitmc_tickList[i].counter = 0;
        kitmc_tickList[i].currentY = kitmc_tickList[i].nextY;
        kitmc_tickList[i].nextY += kitmc_tickList[i].height;
      }


      if (kitmc_tickList[i].currentY >= kitmc_tickList[i].maxY) {
        kitmc_tickList[i].currentY -= kitmc_tickList[i].maxY;
        kitmc_tickList[i].nextY = kitmc_tickList[i].height;
      }
      scrollLayerTo(kitmc_tickList[i].scrollLayer,
                    0, Math.round(kitmc_tickList[i].currentY),
                    false);
    }
  }
}


var origWidth;
var origHeight;



if (kitmc_NS4) {
  origWidth  = window.innerWidth;
  origHeight = window.innerHeight;
}
//window.onresize = kitmc_tickReload;

function kitmc_tickReload() {


  if (kitmc_NS4 && origWidth == window.innerWidth && origHeight == window.innerHeight)
    return;
  window.location.href = window.location.href;
}


//==========================================================================
// SetFont
//==========================================================================
//?,?,width,height,border,start_height
var myScroller1 = new kitmc_ticker(0, 0, 420, 100, 0, 0);
var newsitem = new calvin(0, 0, 420, 100, 0, 0);
//font color, backcolor, bordercolor
//("#006600", "#ccffcc", "#009900");
myScroller1.setColors("#164854", "#FFFFFF", "#FFFFFF");
myScroller1.setFont("굴림체", 2);


//==========================================================================
// Init
//==========================================================================
function calvinscroll() {

  var layer;
  var mikex, mikey;


  layer = getLayer("whatsnew");
  mikex = getPageLeft(layer);
  mikey = getPageTop(layer);

 
  myScroller1.create();
  myScroller1.hide();
  myScroller1.moveTo(mikex, mikey);
  myScroller1.setzIndex(100);
  myScroller1.show();
}

function calvinscroll2() {

                switch (newsitem.items.length) {
			case 2:
			    myScroller1.addItem("<div align='left' valign='top'><table border=0 topmargin='0' marginwidth='0' marginheight='0'><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr><a href='"+newsitem.items[0]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[1]+"</a></font></td></tr></table></div>");
			    break;
			case 4:
			    myScroller1.addItem("<div align='left' valign='top'><table border=0 topmargin='0' marginwidth='0' marginheight='0'><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr><a href='"+newsitem.items[0]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[1]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[2]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[3]+"</a></font></td></tr></table></div>");
			    break;
			case 6:
			    myScroller1.addItem("<div align='left' valign='top'><table border=0 topmargin='0' marginwidth='0' marginheight='0'><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr><a href='"+newsitem.items[0]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[1]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[2]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[3]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[4]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[5]+"</a></font></td></tr></table></div>");
			    break;
			case 8:
			    myScroller1.addItem("<div align='left' valign='top'><table border=0 topmargin='0' marginwidth='0' marginheight='0'><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr><a href='"+newsitem.items[0]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[1]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[2]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[3]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[4]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[5]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[6]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[7]+"</a></font></td></tr></table></div>");
			    break;
			case 10:
			    myScroller1.addItem("<div align='left' valign='top'><table border=0 topmargin='0' marginwidth='0' marginheight='0'><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr><a href='"+newsitem.items[0]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[1]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[2]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[3]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[4]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[5]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[6]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[7]+"</a></font></td></tr><tr><td valign=top align=left><font size=2 class=font9udr><font color='#164854'></td><td valign=top align=left><font size=2 class=font9udr style='line-height:1;font-size:9pt;text-decoration:none;'><a href='"+newsitem.items[8]+"' style='line-height:1;font-size:9pt;text-decoration:none;'><font color='#164854'>"+newsitem.items[9]+"</a></font></td></tr></table></div>");            
			    break;
		}
		calvinscroll();
}

window.onload=calvinscroll2



// MENU
NS4 = (document.layers);
IE4 = (document.all);
ver4 = (NS4 || IE4);
IE5 = (IE4 && navigator.appVersion.indexOf("5.")!=-1);
isMac = (navigator.appVersion.indexOf("Mac") != -1);
isMenu = (NS4 || (IE4 && !isMac) || (IE5 && isMac));

function popUp(){return};
function popDown(){return};

if (!ver4) event = null;

	if (isMenu) {
		menuVersion = 3;
		
		POSSIBLE_MENU_COUNT = 5;
		BUTTON_SPACING = 62;
		BUTTON_START = 163;
		var currentPosition = BUTTON_START;
		for (i=1;i<=POSSIBLE_MENU_COUNT;i++) {
			eval('var arMenu' + i + ' = ""');
		}
		
		//보여줄 서브메뉴의 넓이등 조절
		menuWidth = 350;
		childOverlap = 5;
		childOffset = 5;
		perCentOver = null;
		secondsVisible = .5;
		
		//색깔조정-사용안함 반드시 필요
		fntCol = "#000000";
		fntSiz = "10";
		fntBold = false;
		fntItal = false;
		fntFam = "sans-serif";
		
		backCol = "#FFFFFF";
		overCol = "#FFFFFF";
		overFnt = "#FFFFFF";
		
		borWid = 0;
		borCol = "#000000";
		borSty = "solid";
		itemPad = 3;
		
		imgSrc = "/Images/tri.gif";
		imgSiz = 9;
		
		separator = 1;
		separatorCol = "#000000";
		
		isFrames = false;
		navFrLoc = "left";
		
		keepHilite = true; 
		NSfontOver = true;
		clickStart = false;
		clickKill = false;
	}
arMenu1 = new Array(
		270,
		267,147,
		"","",
		"","",
		"","",
		"<table bgcolor='#E5EBE1' border=0 cellpadding=0 cellspacing=0 width=270><tr><td class=font9udr>&nbsp;&nbsp;&nbsp;<a href='http://sports.kitmc.com/baseball/index.html'><font color=black>야구</font></a> | <a href='http://sports.kitmc.com/basketball/index.html'><font color=black>농구</font></a> | <a href='http://sports.kitmc.com/soccer/index.html'><font color=black>축구</font></a> | <a href='http://sports.kitmc.com/golf/index.html'><font color=black>골프</font></a> | <a href='http://sports.kitmc.com/others/index.html'><font color=black>기타</font></a> | <a href='http://sports.kitmc.com'><font color=black>와글와글</font></a></td></tr></table>","",0);
		currentPosition = currentPosition + BUTTON_SPACING;
		
		
		
		arMenu2 = new Array(
		350,
		346,147,
		"","",
		"","",
		"","",
		"<table bgcolor='#E5EBE1' border=0 cellpadding=0 cellspacing=0 width=350><tr><td class=font9udr>&nbsp;&nbsp;&nbsp; <a href='http://stock.kitmc.com'><font color=black>증권</font></a> | <a href='http://finance.kitmc.com'><font color=black>금융</font></a> | <a href='http://moneybiz.kitmc.com/estate/'><font color=black>부동산</font></a> | <a href='http://www.enuri.com/kitmc/'><font color=black>비교쇼핑</font></a> | <a href='http://job.kitmc.com/'><font color=black>취업</font></a> | <a href='http://moneybiz.kitmc.com/dict/stock.html'><font color=black>경제용어사전</font></a></td></tr></table>","",0);
		currentPosition = currentPosition + BUTTON_SPACING;
		
		arMenu3 = new Array(
		350,
		416,147,
		"","",
		"","",
		"","",
		"<table bgcolor='#E5EBE1' border=0 cellpadding=0 cellspacing=0 width=350><tr><td class=font9udr>&nbsp;&nbsp;&nbsp;<a href='http://cartoon.kitmc.com'><font color=black>Cartoon</font></a> | <a href='http://game.kitmc.com'><font color=black>Game</font></a> | <a href='http://cinezone.kitmc.com'><font color=black>Cinezone</font></a> | <a href='http://baduk.kitmc.com'><font color=black>바둑</font></a> | <a href='http://music.kitmc.com'><font color=black>Musicbox</font></a> | <a href='http://tv.kitmc.com'><font color=black>TV연예</font></a></td></tr></table>","",0);
		currentPosition = currentPosition + BUTTON_SPACING;
		
		
		arMenu4 = new Array(
		235,
		461,147,
		"","",
		"","",
		"","",
		"<table bgcolor='#E5EBE1' border=0 cellpadding=0 cellspacing=0 width=235><tr><td class=font9udr>&nbsp;&nbsp;&nbsp;<a href='http://books.kitmc.com'><font color=black>Books</font></a> | <a href='http://clinic.kitmc.com'><font color=black>Clinic</font></a> | <a href='http://edu.kitmc.com'><font color=black>교육</font></a> | <a href='http://food.kitmc.com'><font color=black>Food</font></a> | <a href='http://travel.kitmc.com'><font color=black>Travel</font></a></td></tr></table>","",0);
		currentPosition = currentPosition + BUTTON_SPACING;
		
		arMenu5 = new Array(
		270,
		500,147,
		"","",
		"","",
		"","",
		"<table bgcolor='#E5EBE1' border=0 cellpadding=0 cellspacing=0 width=270><tr><td class=font9udr>&nbsp;&nbsp;&nbsp;<a href='http://media.kitmc.com/cdong/vl.asp?c=10&y='><font color=black>어린이뉴스</font></a> | <a href='http://media.kitmc.com/cdong/vl.asp?c=20&y='><font color=black>너른배움터</font></a> | <a href='http://media.kitmc.com/cdong/vl.asp?c=30&y='><font color=black>글동산</font></a> | <a href='http://media.kitmc.com/cdong/v40s.asp?c=10&yy='><font color=black>만화마을</font></a></td></tr></table>","",0);
		currentPosition = currentPosition + BUTTON_SPACING;
		
		arMenu6 = new Array(
		250,
		544,147,
		"","",
		"","",
		"","",
		"<table bgcolor='#E5EBE1' border=0 cellpadding=0 cellspacing=0 width=250><tr><td class=font9udr>&nbsp;&nbsp;&nbsp;<a href='http://ngo.kitmc.com/acro/acro.html'><font color=black>아크로폴리스</font></a> | <a href='http://ngo.kitmc.com/fbin/moeum?n=c$50&a=v'><font color=black>NGO 사람들</font></a> | <a href='http://ngo.kitmc.com/click21.html'><font color=black>클릭!현장21</font></a></td></tr></table>","",0);
		currentPosition = currentPosition + BUTTON_SPACING;
		
		
		
		
		
		
		
		

loader = (isFrames) ? (NS4) ? parent : parent.document.body : window;
// loader.onload = startIt;
if(NS4){
	origWidth = loader.innerWidth;
	origHeight = loader.innerHeight;
	loader.onresize = reDo;
}
isLoaded = false;
NSresized = false;

if (!window.menuVersion) {
	clickKill = keepHilite = clickStart = false;
}

if (!window.imgHspace) imgHspace=0;

isWin = (navigator.appVersion.indexOf("Win") != -1)

mSecsVis = secondsVisible*1000;
isRight = (window.navFrLoc && navFrLoc == "right");
fullImgSize = (imgSiz+(imgHspace*2));
if(!IE5) {
	 imgSuf = (isRight) ? ">"  : " ALIGN=RIGHT>";
	 imgStr = "<IMG SRC='" + imgSrc + "' WIDTH=" + imgSiz + " HEIGHT=" + imgSiz +" VSPACE=2 HSPACE="+ imgHspace +" BORDER=0"+ imgSuf;
	 if(IE4) imgStr = "<SPAN STYLE='height:100%;width:"+ (fullImgSize-(isRight?3:0)) +";float:"+ (isRight?"left":"right") +";overflow:hidden'>"+ imgStr +"</SPAN>";
}

areCreated = false;
menuLoc = null;



function initVars() {
	if(areCreated) {
		for(i=1; i<topCount; i++) {
			cur = eval("elMenu"+i);
			clearTimeout(cur.hideTimer);
			cur.hideTimer=null;
		}
		clearTimeout(allTimer);
	}
	topCount = 1;
	areCreated = false;
	beingCreated = false;
	isOverMenu = false;
	currentMenu = null;
	allTimer = null;
}

initVars();

function NSunloaded(){
	isLoaded = false;
}

function NSloaded(e){
	if (e.target.name == mainFrName) {
		initVars();
		startIt();
	}
}

function IEunloaded() {
	initVars();
	isLoaded = false;
	setTimeout("keepTrack()",50)
}

function keepTrack() {
	if (menuLoc.document.readyState == "complete") {
		initVars();
		startIt();
	}
	else {
		setTimeout("keepTrack()",50);
	}
}

function startIt() {
	isLoaded = true;
	if (isFrames) {
		menuLoc = eval("parent.frames." + mainFrName);
		if (NS4) {
			loader.captureEvents(Event.LOAD);
			loader.onload = NSloaded;
			menuLoc.onunload = NSunloaded;
		}
		if (IE4) {
			menuLoc.document.body.onunload = IEunloaded;
		}
	}
	else {
		menuLoc = window;
	}
	menuLoc.nav = nav = window;
	if (clickKill) {
		if (NS4) menuLoc.document.captureEvents(Event.MOUSEDOWN);
		menuLoc.document.onmousedown = clicked;
	}
	makeTop();   
}

function makeTop(){
	beingCreated = true;
	if(IE4) {
		topZ = 0;
		for (z=0;z<menuLoc.document.all.length;z++){
			oldEl = menuLoc.document.all(z);
			topZ = Math.max(oldEl.style.zIndex,topZ)
		}
	}
	while(eval("window.arMenu" + topCount)) {
		(NS4) ? makeMenuNS(false,topCount) : makeMenuIE(false,topCount);
		topCount++
	}

	//status = (topCount-1) + " Hierarchical Menu Trees Created"
	areCreated = true;
	beingCreated = false;
}

function makeMenuNS(isChild,menuCount,parMenu,parItem) {
	tempArray = eval("arMenu" + menuCount);
	
	if (!isChild) {
		tempWidth = tempArray[0] ? tempArray[0] : menuWidth;
		
		menu = makeElement("elMenu" + menuCount,tempWidth,null,null);
	}
	else {
		menu = makeElement("elMenu" + menuCount,null,parMenu,null);
	}
	menu.array = tempArray;
	menu.setMenuTree = setMenuTree;
	menu.setMenuTree(isChild,parMenu);

	while (menu.itemCount < menu.maxItems) {
		menu.itemCount++;
		//status = "Creating Hierarchical Menus: " + menuCount + " / " + menu.itemCount;
		prevItem = (menu.itemCount > 1) ? menu.item : null;
		itemName = "item" + menuCount + "_" + menu.itemCount;

		menu.item = makeElement(itemName,null,null,menu);

		menu.item.prevItem = prevItem;
		menu.item.setup = itemSetup;
		menu.item.setup(menu.itemCount,menu.array);
		if (menu.item.hasMore) {
			makeMenuNS(true,menuCount + "_" + menu.itemCount,menu,menu.item);
			menu = menu.parentMenu;
		}
	}
	menu.lastItem = menu.item;
	menu.setup(isChild,parMenu,parItem);
}

function findTree(men){
	foundTree = false;
	for(i=11;i<men.array.length;i+=3){
		if(men.array[i]) {
			foundTree = true;
			break;
		}
	}
	return foundTree;
}

function setMenuTree(isChild,parMenu) {
	if (!isChild) {
		this.menuWidth = this.array[0] ? this.array[0] : menuWidth;
		
		this.menuLeft = this.array[1];
		this.menuTop = this.array[2];
		this.menuFontColor = this.array[3] ? this.array[3] : fntCol;
		this.menuFontOver = this.array[4] ? this.array[4] : overFnt;
		//this.menuBGColor = this.array[5] ? this.array[5] : backCol;
		//this.menuBGOver = this.array[6] ? this.array[6] : overCol;
		this.menuBorCol = this.array[7] ? this.array[7] : borCol;
		this.menuSeparatorCol = this.array[8] ? this.array[8] : separatorCol;
		this.treeParent = this;
		this.startChild = this;
		this.isTree = findTree(this);
	}
	else {
		this.menuWidth = parMenu.menuWidth;
		this.menuLeft = parMenu.menuLeft;
		this.menuTop = parMenu.menuTop;
		this.menuFontColor = parMenu.menuFontColor;
		this.menuFontOver = parMenu.menuFontOver;
		//this.menuBGColor = parMenu.menuBGColor;
		//this.menuBGOver = parMenu.menuBGOver;
		this.menuBorCol = parMenu.menuBorCol;
		this.menuSeparatorCol = parMenu.menuSeparatorCol;
		this.treeParent = parMenu.treeParent;
		this.isTree = parMenu.isTree;
	}

	this.maxItems = (isChild) ? this.array.length/3 : (this.array.length-9)/3;
	this.hasParent = isChild;
	this.setup = menuSetup;
	this.itemCount = 0;
}

function makeMenuIE(isChild,menuCount,parMenu) {
	menu = makeElement("elMenu" + menuCount);
	menu.array = eval("arMenu" + menuCount);
	menu.setMenuTree = setMenuTree;
	menu.setMenuTree(isChild,parMenu);
	menu.itemStr = "";
	
	while (menu.itemCount < menu.maxItems) {
		menu.itemCount++;
		//status = "Creating Hierarchical Menus: " + menuCount + " / " + menu.itemCount;
		itemName = "item" + menuCount + "_" + menu.itemCount;

		arrayPointer = (isChild) ? (menu.itemCount-1)*3 :((menu.itemCount-1)*3)+9;
		dispText = menu.array[arrayPointer];
		hasMore = menu.array[arrayPointer + 2];

		if(IE5) {
			newSpan = menuLoc.document.createElement("SPAN");
			with(newSpan) {
				id = itemName;
				with(style) {
					width = (menu.menuWidth-(borWid*2));
					fontSize = fntSiz + "px";
					fontWeight = (fntBold) ? "bold" : "normal";
					fontStyle = (fntItal) ? "italic" : "normal";
					fontFamily = fntFam;
					padding = itemPad;
					borderBottomWidth = separator + "px";
					borderBottomStyle = "solid";
				}
				innerHTML = dispText;
			}
	
			newBreak = menuLoc.document.createElement("BR");
			menu.appendChild(newSpan);
			menu.appendChild(newBreak);
			if(hasMore) {

//3.10.2 added next 2 statements:
				if (isRight) newSpan.style.paddingLeft = itemPad+fullImgSize;
				else newSpan.style.paddingRight = itemPad+fullImgSize;

				newImage = menuLoc.document.createElement("IMAGE");
				with(newImage){
					src = imgSrc;
					with(style) {
						position = "absolute";
						width = imgSiz;
						height = imgSiz;
						left = (isRight) ? itemPad : (newSpan.style.pixelWidth - itemPad - imgSiz);
						top = newSpan.offsetTop + itemPad + (isMac ? 0 : 2);
					}
				}
				newSpan.appendChild(newImage);
			}
		}
		else {
			htmStr = (hasMore) ? imgStr + dispText : dispText;
			menu.itemStr += "<SPAN ID=" + itemName + " STYLE=\"width:" + (menu.menuWidth-(borWid*2)) + "\">" + htmStr + "</SPAN><BR>";
		}
		if (hasMore) {
			makeMenuIE(true,menuCount + "_" + menu.itemCount,menu);
			menu = menu.parentMenu;
		}
	}

	if(!IE5) menu.innerHTML = menu.itemStr;

	itemColl = menu.children.tags("SPAN");
	for (i=0; i<itemColl.length; i++) {
		it = itemColl(i);
		it.setup = itemSetup;
		it.setup(i+1,menu.array);
	}
	menu.lastItem = itemColl(itemColl.length-1);
	menu.setup(isChild,parMenu);
}

function makeElement(whichEl,whichWidth,whichParent,whichContainer) {
	if (NS4) {
		if (whichWidth) {
			elWidth = whichWidth;
			
		}
		else {
			elWidth = (whichContainer) ? whichContainer.menuWidth : whichParent.menuWidth;
			if (whichContainer) elWidth = elWidth-(borWid*2)-(itemPad*2);
			
		}
		if (!whichContainer) whichContainer = menuLoc;
		eval(whichEl + "= new Layer(elWidth,whichContainer)");
	}
	else {
		if (IE5) {
			newDiv = menuLoc.document.createElement("DIV");
			newDiv.style.position = "absolute";
			newDiv.id = whichEl;
			menuLoc.document.body.appendChild(newDiv);
			
		}
		else {
			elStr = "<DIV ID=" + whichEl + " STYLE='position:absolute'></DIV>";
			
			menuLoc.document.body.insertAdjacentHTML("BeforeEnd",elStr);
		}
		if (isFrames) eval(whichEl + "= menuLoc." + whichEl);
	}
	
	return eval(whichEl);
}

function itemSetup(whichItem,whichArray) {
	this.onmouseover = itemOver;
	this.onmouseout = itemOut;
	this.container = (NS4) ? this.parentLayer : this.parentElement;

	arrayPointer = (this.container.hasParent) ? (whichItem-1)*3 : ((whichItem-1)*3)+9;
	this.dispText = whichArray[arrayPointer];
	this.linkText = whichArray[arrayPointer + 1];
	this.hasMore = whichArray[arrayPointer + 2];

	if (IE4 && this.hasMore) {
		this.child = eval("elMenu" + this.id.substr(4));
		this.child.parentMenu = this.container;
		this.child.parentItem = this;
	}

	if (this.linkText) {
		if (NS4) {
			this.captureEvents(Event.MOUSEUP)
			this.onmouseup = linkIt;
		}
		else {
			this.onclick = linkIt;
			this.style.cursor = "hand";
		}
	}

	if (NS4) {
		htmStr = this.dispText;
		if (fntBold) htmStr = htmStr.bold();
		if (fntItal) htmStr = htmStr.italics();

		htmStr = "<FONT FACE='" + fntFam + "' POINT-SIZE=" + fntSiz + ">" + htmStr+ "</FONT>";
		this.htmStrOver = htmStr.fontcolor(this.container.menuFontOver);
		this.htmStr = htmStr.fontcolor(this.container.menuFontColor);
		if(this.hasMore) {
			this.document.write(imgStr);
			this.document.close();
		}
		this.visibility = "inherit";
		//this.bgColor = this.container.menuBGColor;
		if (whichItem == 1) {
			this.top = borWid + itemPad;
		}
		else {
			this.top = this.prevItem.top + this.prevItem.clip.height + separator;
		}
		this.left = borWid + itemPad;
		this.clip.top = this.clip.left = -itemPad;
		this.clip.right = this.container.menuWidth-(borWid*2)-itemPad;
		maxTxtWidth = this.container.menuWidth-(borWid*2)-(itemPad*2);
		if (this.container.isTree) maxTxtWidth-=(fullImgSize);

		this.txtLyrOff = new Layer(maxTxtWidth,this);
		if (isRight && this.container.isTree) this.txtLyrOff.left = fullImgSize;
		this.txtLyrOff.document.write(this.htmStr);
		this.txtLyrOff.document.close();
		this.txtLyrOff.visibility = "inherit";

		this.clip.bottom = this.txtLyrOff.document.height+itemPad;

		this.txtLyrOn = new Layer(maxTxtWidth,this);
		if (isRight && this.container.isTree) this.txtLyrOn.left = fullImgSize;
		this.txtLyrOn.document.write(this.htmStrOver);
		this.txtLyrOn.document.close();
		this.txtLyrOn.visibility = "hide";

		this.dummyLyr = new Layer(100,this);
		this.dummyLyr.left = this.dummyLyr.top = -itemPad;
		this.dummyLyr.clip.width = this.clip.width;
		this.dummyLyr.clip.height = this.clip.height;
		this.dummyLyr.visibility = "inherit";
	}
	else {
		with (this.style) {
			if(!IE5) {
				fontSize = fntSiz + "pt";
				fontWeight = (fntBold) ? "bold" : "normal";
				fontStyle =   (fntItal) ? "italic" : "normal";
				fontFamily = fntFam;
				padding = itemPad;
				borderBottomWidth = separator + "px";
				borderBottomStyle = "solid";
			}

//3.10.2 modified next statement to one following
//			if (this.container.isTree && (IE5 || (!IE5 && !this.hasMore))) {
			if (this.container.isTree && !this.hasMore) {
				if (isRight) paddingLeft = itemPad+fullImgSize;
				else paddingRight = itemPad+fullImgSize;
			}
			color = this.container.menuFontColor;
			borderBottomColor = this.container.menuSeparatorCol;
			//backgroundColor = this.container.menuBGColor;
		}
	}
}   

function menuSetup(hasParent,openCont,openItem) {
	this.onmouseover = menuOver;
	this.onmouseout = menuOut;
	
	this.showIt = showIt;
	this.keepInWindow = keepInWindow;
	this.hideTree = hideTree
	this.hideParents = hideParents;
	this.hideChildren = hideChildren;
	this.hideTop = hideTop;
	this.hasChildVisible = false;
	this.isOn = false;
	this.hideTimer = null;

	this.childOverlap = (perCentOver != null) ? ((perCentOver/100) * this.menuWidth) : childOverlap;
	this.currentItem = null;
	this.hideSelf = hideSelf;
		
	if (hasParent) {
		this.hasParent = true;
		this.parentMenu = openCont;
		if (NS4) {
			this.parentItem = openItem;
			this.parentItem.child = this;
		}
	}
	else {
		this.hasParent = false;
	}

	if (NS4) {
		//this.bgColor = this.menuBorCol;
		this.fullHeight = this.lastItem.top + this.lastItem.clip.bottom + borWid;
		this.clip.right = this.menuWidth;
		this.clip.bottom = this.fullHeight;
	}
	else {
		with (this.style) {
			width = this.menuWidth;
			borderWidth = borWid;
			borderColor = this.menuBorCol;
			borderStyle = borSty;
			zIndex = topZ;

//3.10.2 added next statement
			overflow = "hidden";
		}
		this.lastItem.style.border="";
		this.fullHeight = this.offsetHeight;
		if(isMac)this.style.pixelHeight = this.fullHeight;
		this.fullHeight = this.scrollHeight;
		this.showIt(false);
		this.onselectstart = cancelSelect;
		this.moveTo = moveTo;
		this.moveTo(0,0);
	}
}

function popUp(menuName,e){
	
	if (NS4 && NSresized) startIt();
	//if (!isLoaded) alert("babo"); return;
	
	
	linkEl = (NS4) ? e.target : event.srcElement;
	if (clickStart) linkEl.onclick = popMenu;
	if (!beingCreated && !areCreated) startIt();
	linkEl.menuName = menuName;   
	if (!clickStart) popMenu(e);
	
}

function popMenu(e){
	if (!isLoaded || !areCreated) return true;

	eType = (NS4) ? e.type : event.type;
	if (clickStart && eType != "click") return true;
	hideAll();

	linkEl = (NS4) ? e.target : event.srcElement;
	
	currentMenu = eval(linkEl.menuName);
	currentMenu.hasParent = false;
	currentMenu.treeParent.startChild = currentMenu;
	
	if (IE4) menuLocBod = menuLoc.document.body;
	if (!isFrames) {
		
		xPos = (currentMenu.menuLeft) ? currentMenu.menuLeft : (NS4) ? e.pageX : (event.clientX + menuLocBod.scrollLeft);
		//xPos = (currentMenu.menuLeft) ? currentMenu.menuLeft : (NS4) ? e.pageX : (event.clientX);
		yPos = (currentMenu.menuTop) ? currentMenu.menuTop : (NS4) ? e.pageY : (event.clientY + menuLocBod.scrollTop);
		//yPos = (currentMenu.menuTop) ? currentMenu.menuTop : (NS4) ? e.pageY : (event.clientY);
		if(NS4){
			yPos = yPos+4;
		}
	}
	else {
		
		switch (navFrLoc) {
			case "left":
				xPos = (currentMenu.menuLeft) ? currentMenu.menuLeft : (NS4) ? menuLoc.pageXOffset : menuLocBod.scrollLeft;
				yPos = (currentMenu.menuTop) ? currentMenu.menuTop : (NS4) ? (e.pageY-pageYOffset)+menuLoc.pageYOffset : event.clientY + menuLocBod.scrollTop;
				break;
			case "top":
				xPos = (currentMenu.menuLeft) ? currentMenu.menuLeft : (NS4) ? (e.pageX-pageXOffset)+menuLoc.pageXOffset : event.clientX + menuLocBod.scrollLeft;
				yPos = (currentMenu.menuTop) ? currentMenu.menuTop : (NS4) ? menuLoc.pageYOffset : menuLocBod.scrollTop;
				break;
			case "bottom":
				xPos = (currentMenu.menuLeft) ? currentMenu.menuLeft : (NS4) ? (e.pageX-pageXOffset)+menuLoc.pageXOffset : event.clientX + menuLocBod.scrollLeft;
				yPos = (currentMenu.menuTop) ? currentMenu.menuTop : (NS4) ? menuLoc.pageYOffset+menuLoc.innerHeight : menuLocBod.scrollTop + menuLocBod.clientHeight;
				break;
			case "right":
				xPos = (currentMenu.menuLeft) ? currentMenu.menuLeft : (NS4) ? menuLoc.pageXOffset+menuLoc.innerWidth : menuLocBod.scrollLeft+menuLocBod.clientWidth;
				yPos = (currentMenu.menuTop) ? currentMenu.menuTop : (NS4) ? (e.pageY-pageYOffset)+menuLoc.pageYOffset : event.clientY + menuLocBod.scrollTop;
				break;
		}
	}

	currentMenu.moveTo(xPos,yPos);
	currentMenu.keepInWindow()
	currentMenu.isOn = true;
	currentMenu.showIt(true);

	return false;
}

function menuOver(e) {
	this.isOn = true;
	isOverMenu = true;
	currentMenu = this;
	if (this.hideTimer) clearTimeout(this.hideTimer);
}

function menuOut() {
	if (IE4) {
		theEvent = menuLoc.event;
		if (theEvent.srcElement.contains(theEvent.toElement)) return;
	}
	this.isOn = false;
	isOverMenu = false;

	menuLoc.status = "";
	if (!clickKill) allTimer = setTimeout("currentMenu.hideTree()",10);  
}

function itemOver(){
	if (keepHilite) {
		if (this.container.currentItem && this.container.currentItem != this) {
			if (NS4) {
				//this.container.currentItem.bgColor = this.container.menuBGColor;
				this.container.currentItem.txtLyrOff.visibility = "inherit";
				this.container.currentItem.txtLyrOn.visibility = "hide";
			}
			else {
				with (this.container.currentItem.style) {
					//backgroundColor = this.container.menuBGColor;
					color = this.container.menuFontColor;
				}
			}
		}
	}

	if (IE4) {
		theEvent = menuLoc.event;
		if (theEvent.srcElement.tagName == "IMG") return;
		//this.style.backgroundColor = this.container.menuBGOver;
		this.style.color = this.container.menuFontOver;
	}
	else {
		//this.bgColor = this.container.menuBGOver;
		this.txtLyrOff.visibility = "hide";
		this.txtLyrOn.visibility = "inherit";
	}

	//menuLoc.status = this.linkText;

	this.container.currentItem = this;

	if (this.container.hasChildVisible) {
		this.container.hideChildren(this);
	}

	if (this.hasMore) {
		horOffset = (isRight) ? (this.container.childOverlap - this.container.menuWidth) : (this.container.menuWidth - this.container.childOverlap);

		if (NS4) {
			this.childX = this.container.left + horOffset;
			this.childY = (this.pageY+this.clip.top) + childOffset;
		}
		else {
			this.childX = this.container.style.pixelLeft + horOffset;
			this.childY = this.offsetTop + this.container.style.pixelTop + childOffset + borWid;
		}
		
		this.child.moveTo(this.childX,this.childY);
		this.child.keepInWindow();
		this.container.hasChildVisible = true;
		this.container.visibleChild = this.child;
		this.child.showIt(true);
	}
}

function itemOut() {
	if (IE4) {
		theEvent = menuLoc.event;
		 if (theEvent.srcElement.contains(theEvent.toElement)
	  || (theEvent.fromElement.tagName=="IMG" && theEvent.toElement.contains(theEvent.fromElement)))
		  return;
		if (!keepHilite) {
			//this.style.backgroundColor = this.container.menuBGColor;
			this.style.color = this.container.menuFontColor;
		}
	}
	else {
		if (!keepHilite) {
			//this.bgColor = this.container.menuBGColor;
			this.txtLyrOff.visibility = "inherit";
			this.txtLyrOn.visibility = "hide";
		}
		if (!isOverMenu && !clickKill) {
			allTimer = setTimeout("currentMenu.hideTree()",10); 
		}
	}
}

function moveTo(xPos,yPos) {
	this.style.pixelLeft = xPos;
	
	this.style.pixelTop = yPos;
}

function showIt(on) {
	if (NS4) {
		this.visibility = (on) ? "show" : "hide";
		if (keepHilite && this.currentItem) {
			//this.currentItem.bgColor = this.menuBGColor;
			this.currentItem.txtLyrOff.visibility = "inherit";
			this.currentItem.txtLyrOn.visibility = "hide";
		}
	}
	else {
		this.style.visibility = (on) ? "visible" : "hidden";
		if (keepHilite && this.currentItem) {
			with (this.currentItem.style) {
				//backgroundColor = this.menuBGColor;
				color = this.menuFontColor;
			}
		}
	}
	this.currentItem = null;
}

function keepInWindow() {
	scrBars = 20;
	botScrBar = (isFrames && navFrLoc=="bottom") ? (borWid*2) : scrBars;
	rtScrBar = (isFrames && navFrLoc=="right") ? (borWid*2) : scrBars;
	
	if (NS4) {
		winRight = (menuLoc.pageXOffset + menuLoc.innerWidth) - rtScrBar;
		//rightPos = this.left + this.menuWidth;
		rightPos =  this.menuWidth;
	
		if (rightPos > winRight) {
			if (this.hasParent) {
				parentLeft = this.parentMenu.left;
				newLeft = ((parentLeft-this.menuWidth) + this.childOverlap);
				this.left = newLeft;
			}
			else {
				dif = rightPos - winRight;
				this.left -= dif;
			}
		}

		winBot = (menuLoc.pageYOffset + menuLoc.innerHeight) - botScrBar ;
		botPos = this.top + this.fullHeight;

		if (botPos > winBot) {
			dif = botPos - winBot;
			this.top -= dif;
		}
		
		winLeft = menuLoc.pageXOffset;
		leftPos = this.left;

		if (leftPos < winLeft) {
			if (this.hasParent) {
				parentLeft = this.parentMenu.left;
				newLeft = ((parentLeft+this.menuWidth) - this.childOverlap);
				this.left = newLeft;
			}
			else {
				this.left = 5;
			}
		}
	}
	else {
		 winRight = (menuLoc.document.body.scrollLeft + menuLoc.document.body.clientWidth) - rtScrBar;
		//rightPos = this.style.pixelLeft + this.menuWidth; ->화면에 보이는 메뉴는 다보이도록 하기 위해서..
		rightPos =  this.menuWidth;
		
		if (rightPos > winRight) {
			if (this.hasParent) {
				parentLeft = this.parentMenu.style.pixelLeft;
				newLeft = ((parentLeft - this.menuWidth) + this.childOverlap);
				this.style.pixelLeft = newLeft;
			}
			else {
				dif = rightPos - winRight;
				this.style.pixelLeft -= dif;
			}
		}

		winBot = (menuLoc.document.body.scrollTop + menuLoc.document.body.clientHeight) - botScrBar;
		botPos = this.style.pixelTop + this.fullHeight;

		if (botPos > winBot) {
			dif = botPos - winBot;
			this.style.pixelTop -= dif;
		}
		
		winLeft = menuLoc.document.body.scrollLeft;
		leftPos = this.style.pixelLeft;

		if (leftPos < winLeft) {
			if (this.hasParent) {
				parentLeft = this.parentMenu.style.pixelLeft;
				newLeft = ((parentLeft+this.menuWidth) - this.childOverlap);
				this.style.pixelLeft = newLeft;
			}
			else {
				this.style.pixelLeft = 5;
			}
		}
	}
}

function linkIt() {
	if (this.linkText.indexOf("javascript:")!=-1) eval(this.linkText)
	else menuLoc.location.href = this.linkText;
}

function popDown(menuName){
	if (!isLoaded || !areCreated) return;
	whichEl = eval(menuName);
	whichEl.isOn = false;
	if (!clickKill) whichEl.hideTop();
}

function hideAll() {
	for(i=1; i<topCount; i++) {
		temp = eval("elMenu" + i + ".startChild");
		temp.isOn = false;
		if (temp.hasChildVisible) temp.hideChildren();
		temp.showIt(false);
	}   
}

function hideTree() { 
	allTimer = null;
	if (isOverMenu) return;
	if (this.hasChildVisible) {
		this.hideChildren();
	}
	this.hideParents();
}

function hideTop() {
	whichTop = this;
	(clickKill) ? whichTop.hideSelf() : (this.hideTimer = setTimeout("if(whichTop.hideSelf)whichTop.hideSelf()",mSecsVis));
}

function hideSelf() {
	this.hideTimer = null;
	if (!this.isOn && !isOverMenu) { 
		this.showIt(false);
	}
}

function hideParents() {
	tempMenu = this;
	while (tempMenu.hasParent) {
		tempMenu.showIt(false);
		tempMenu.parentMenu.isOn = false;      
		tempMenu = tempMenu.parentMenu;
	}
	tempMenu.hideTop();
}

function hideChildren(item) {
	tempMenu = this.visibleChild;
	while (tempMenu.hasChildVisible) {
		tempMenu.visibleChild.showIt(false);
		tempMenu.hasChildVisible = false;
		tempMenu = tempMenu.visibleChild;
	}

	if (!this.isOn || !item.hasMore || this.visibleChild != this.child) {
		this.visibleChild.showIt(false);
		this.hasChildVisible = false;
	}
}

function cancelSelect(){return false}

function reDo(){
	if (loader.innerWidth==origWidth && loader.innerHeight==origHeight) return;
	initVars();
	NSresized=true;
	menuLoc.location.reload();
}

function clicked() {
	if (!isOverMenu && currentMenu!=null && !currentMenu.isOn) {
		whichEl = currentMenu;
		whichEl.hideTree();
	}
}

window.onerror = handleErr;

function handleErr(){
	arAccessErrors = ["permission","access"];
	mess = arguments[0].toLowerCase();
	found = false;
	for (i=0;i<arAccessErrors.length;i++) {
		errStr = arAccessErrors[i];
		if (mess.indexOf(errStr)!=-1) found = true;
	}
	return found;
}

//end