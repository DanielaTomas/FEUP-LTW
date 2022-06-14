const searchRestaurant = document.querySelector('#searchrestaurant')
if (searchRestaurant) {
    searchRestaurant.addEventListener('input', async function() {
        const response = await fetch('../Api/restaurants.api.php?search=' + escapeHtml(this.value))
        const restaurants = await response.json()

        const section = document.querySelector('#restaurants')
        section.innerHTML = ''

        for (const restaurant of restaurants) {
            const article = document.createElement('article')
            const img = document.createElement('img')
            img.src = restaurant.image
            const link = document.createElement('a')
            link.href = '../Pages/restaurant.php?id=' + restaurant.id
            link.textContent = restaurant.name
            article.appendChild(img)
            article.appendChild(link)
            section.appendChild(article)
        }
    })
}

const entityMap = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;',
    "/": '&#x2F;'
};

function escapeHtml(string) {
    return String(string).replace(/[&<>"'\/]/g, function(s) {
        return entityMap[s];
    });
}

function deleteRow(r) {
    var i = r.parentNode.parentNode.rowIndex
    document.getElementById("ordersTable").deleteRow(i)
}

$(document).ready(function() {
    $('#submitReview').on('click', function() {
        $("#submitReview").attr("disabled", "disabled")
        var score = $('#score').val()
        var comment = $('#reviewText').val()
        var url = escapeHtml(window.location.search);
        var restaurantid = url.substring(url.lastIndexOf('/') + 5);
        $.ajax({
            url: "../Api/saveReview.api.php",
            type: "POST",
            data: {
                score: score,
                comment: comment,
                restaurantid: restaurantid
            },
            cache: false,
            success: function(response) {
                var res = JSON.parse(response)
                console.log(res)
            }
        });
        window.location.href = "refresh.php";
        //$("#userReview").load(location.href + " p");
    });
});