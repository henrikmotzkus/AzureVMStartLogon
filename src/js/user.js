async function getUserInfo() {
    const response = await fetch('/.auth/me');
    const payload = await response.json();
    const { clientPrincipal } = payload;
    console.log(getUserInfo());
    return clientPrincipal;
}

async function renderUserDetails(){
    let html = <p>${userDetails}</p>
    let container = document.querySelector('.container');
    container.innerHTML = html;
}

renderUserDetails();

