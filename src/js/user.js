async function getUserInfo() {
    const response = await fetch('/.auth/me');
    const payload = await response.json();
    
    const { clientPrincipal } = payload;
    
    console.log(payload.clientPrincipal.userDetails);
    return payload.clientPrincipal.userDetails;
}

async function renderUserDetails(){
    let userdetails = getUserInfo();
    let html = `<p>${userdetails}</p>`;
    let container = document.querySelector('.container');
    container.innerHTML = html;
}

renderUserDetails();
