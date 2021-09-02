async function getUserInfo() {
    const response = await fetch('/.auth/me');
    const payload = await response.json();
    const { clientPrincipal } = payload;
    console.log(json.clientPrincipal.userDetails);
    return json.clientPrincipal.userDetails;
}

async function renderUserDetails(){
    let userdetails = getUserInfo();
    let html = `<p>${userdetails}</p>`;
    let container = document.querySelector('.container');
    container.innerHTML = html;
}

renderUserDetails();

