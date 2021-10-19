/* toggle the side nav menu */
function toggleNav() {
  myStorage = window.localStorage;

  /* return or initialize site nav toggle site bool var */
  if (localStorage.getItem('sidebar-toggle') == null){
    toggleBool = localStorage.setItem('sidebar-toggle', 'inactive');
  }else{
    toggleBool = localStorage.getItem('sidebar-toggle');
  }
  
  /* open/close sidenav by adding/removing the sidebar-active class defined in
  css */
  if (toggleBool == 'inactive'){
    document.getElementById("s-layout-sidebar").classList.add("sidebar-active");
    document.getElementById("s-layout-content").classList.add("sidebar-active");
    localStorage.setItem('sidebar-toggle', 'active');
  }else{
    /* close sidenav by removing the sidebar-active class */
    document.getElementById("s-layout-sidebar").classList.remove("sidebar-active");
    document.getElementById("s-layout-content").classList.remove("sidebar-active");
    localStorage.setItem('sidebar-toggle', 'inactive');
  }
  
}


/* initialize sidnav local storage */
myStorage = window.localStorage;
localStorage.setItem('sidebar-toggle', 'inactive');