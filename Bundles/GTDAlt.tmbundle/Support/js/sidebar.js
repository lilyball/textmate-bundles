function toggle_sublist(e) {
  if (this == e.target) {
    if (this.className == "collapse")
      this.className = "";
    else
      this.className = "collapse";
  }
  return true;
}
function toggle_this() {
  var body_tag = document.getElementsByTagName('body')[0];
  var the_name = this.name;
  var i = body_tag.className.indexOf(the_name);
  var c_name = body_tag.className;
  if  (i == -1) {
    body_tag.className = the_name + " " + c_name;
  } else {
    body_tag.className = c_name.substring(0,i) + c_name.substring(i+the_name.length,c_name.length);
  }
  return true;
}
function get_toggles() {
  var list = document.getElementById('toggles').childNodes;
  var to_return = new Array;
  for (i=0;i<list.length;i++) {
    if (list[i].nodeName == 'LI')
      to_return.push(list[i]);
  }
  return to_return;
}
function create_nav_list() {
  var main_level = get_toggles();
  for (var i=0;i<main_level.length;i++) {
    main_level[i].onclick = toggle_sublist;
    var title = full_text(main_level[i]).substring(0,3).toLowerCase();
    main_level[i].innerHTML += create_list_part(title,
                            main_level[i].getAttribute('tablecolumn'));
  }
  var els = document.getElementById('toggles').getElementsByTagName('input');
  for (i=0;i<els.length;i++) {
    els[i].onclick = toggle_this;
  }
}
function create_list_part(type_name,index) {
  var titles = find_values(index);
  var str = '<ul id="'+ type_name + '">';
  for (var i=0;i<titles.length;i++) {
    var link_str = '<li><input type="checkbox" name="TEMPLATE-' + i + '-hide" id="TEMPLATE-' + i + '-button" checked = "true" >'+ titles[i] + '</li>'
    str += string_substitute(link_str,"TEMPLATE",type_name);
  }
  str += "</ul>";
  return str;
}
function find_contexts () {
  return find_values(0)
}

function find_values(index){
  var tags = document.getElementsByTagName('tr');
  var contexts = new Array;
  for (i=0;i<tags.length;i++) {
    el = tags[i].getElementsByTagName('td')[index];
    if (el) {
      var txt = full_text(el);
      var found = false;
      for (j=0;j<contexts.length;j++) {
        if (contexts[j] == txt)
          found = true;
      }
      if (!found)
        contexts.push(txt);
    }
  }
  return contexts;
}
function set_tr_classes() {
  var trs = document.getElementsByTagName('tr');
/*  set_class(trs[1]);
  set_class(trs[2]);
*/
  for (var i=1;i<trs.length;i++) {
    set_class(trs[i]);
  }
}
function set_class(tr) {
  var main_level = document.getElementById('toggles');
  for (var i=0;i<CH_titles.length;i++) {
    var txt = tr.getAttribute(CH_titles[i]);
    var list = document.getElementById(CH_titles[i]);
    if (list) {
      var list_items = list.getElementsByTagName('li');
      for (var j=0; j < list_items.length; j++) {
        if(full_text(list_items[j]) == txt) {
          tr.className += " " + CH_titles[i] + "-" + j;
          break;
        }
      }
    }
  }
}
function string_substitute(string,find,replace) {
  var parts = string.split(find);
  var str = parts.shift();
  while (parts[0]) {
    str = str + replace + parts.shift();
  }
  return str;
}
function mark_trs() {
  var trs = document.getElementsByTagName('tr');
  var heads = trs[0].getElementsByTagName('th');
  for (var i=0; i < heads.length; i++) {
    CH_titles.push(full_text(heads[i]).substring(0,3).toLowerCase());
  };
  for (var i=1; i < trs.length; i++) {
    var tds = trs[i].getElementsByTagName('td');
    for (var j=0; j < tds.length; j++) {
      trs[i].setAttribute(CH_titles[j],full_text(tds[j]));
    };
  };
}
function full_text(node) {
  if (node.nodeType == 3) /*text node*/
    return node.nodeValue;
  else {
    var str = "";
    for (var i=0;i<node.childNodes.length;i++)
      str += full_text(node.childNodes[i]);
    return str;
  }
}
function mark_table() {
  var tab = document.getElementsByTagName('table')[0];
  tab.className += " sortable";
  tab.id = "table_unique";
}
var CH_titles = new Array;
window.onload = function () {
  create_nav_list();
  mark_trs();
  set_tr_classes();
  mark_table();
  sortables_init();
  return true;
};