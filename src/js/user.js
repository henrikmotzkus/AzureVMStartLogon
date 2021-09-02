async function getUserInfo() {
    const response = await fetch('/.auth/me');
    const payload = await response.json();
    
    const { clientPrincipal } = payload;
    
    console.log(payload.clientPrincipal.userDetails);
    return payload.clientPrincipal.userDetails;
}

async function renderUserDetails(){
    let user = await getUserInfo();
    let html = `<p> ${user} </p>`;
    let container = document.getElementById('heretheuser');
    container.innerHTML = html;
}

renderUserDetails();
