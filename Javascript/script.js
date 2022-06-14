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


//----------------------------------------------------------------

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

//----------------------------------------------------------------

function deleteRow(r) {
    var i = r.parentNode.parentNode.rowIndex
    document.getElementById("ordersTable").deleteRow(i)
}

//---------------------------------------------------------------
/*function getReview() {
    document.getElementById('score').value = "<?= $_GET['score'];?>";
}*/

$(document).ready(function() {
    $('#submitReview').on('click', function() {
        $("#submitReview").attr("disabled", "disabled");
        var score = $('#score').val();
        var comment = $('#reviewText').val();
        $.ajax({
            url: "../Api/saveReview.api.php",
            type: "POST",
            data: {
                score: score,
                comment: comment
            },
            cache: false,
            success: function(response) {
                var res = JSON.parse(response);
                console.log(res);
                /*  if (res.statusCode == 200) {
                      $("#submitReview").removeAttr("disabled")
                      $('#reviewForm').find('textarea').val('')
                          //$("#success").show();
                          //$('#success').html('Your review was submitted with success!');
                  } else if (res.statusCode == 201) {
                      alert("Error occured!")
                  }*/

            }
        });

    });
});