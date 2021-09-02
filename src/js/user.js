async function getUserInfo() {
    const response = await fetch('/.auth/me');
    const payload = await response.json();
    
    const { clientPrincipal } = payload;
    
    if (payload.clientPrincipal.userDetails) {
        console.log(payload.clientPrincipal.userDetails);
        return payload.clientPrincipal.userDetails;
    } else {
        return null;
    }
  
    
}

async function renderUserDetails(){
    let user = await getUserInfo();
    let html = `<p> ${user} </p>`;
    let container = document.getElementById('heretheuser');
    container.innerHTML = html;

    let html2 = `<a class="btn btn-primary" href="/StartVM">VM Panel</a></p>`;
    let container2 = document.getElementById('herethevmpanel');
    container2.innerHTML = html2;

    if (user){

        let html3 = `<p><a class="btn btn-primary" href="/.auth/logout">Log out ${user}</a></p>`;
        let container3 = document.getElementById('heretheloginlogout');
        container3.innerHTML = html3;

        

    } else {

        let html4 = ` <p><a class="btn btn-primary" href="/.auth/login/aad">Login</a></p>`;
        let container4 = document.getElementById('heretheloginlogout');
        container4.innerHTML = html4;

       
    }

}



renderUserDetails();
