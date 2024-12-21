// mostrar de forma dinamica los datos den eventos
document.addEventListener('DOMContentLoaded', function() {
    // Cargar los primeros 6 eventos
    fetch('cgi-bin/mostrar_eventos.pl')
        .then(response => response.json())
        .then(data => {
            var eventBoxes = document.querySelectorAll('.event-box');

            data.forEach((event, index) => {
                if (index < eventBoxes.length) {
                    var eventBox = eventBoxes[index];
                    eventBox.querySelector('h3').textContent = event.titulo;
                    eventBox.querySelector('p:nth-of-type(1)').textContent = event.descripcion;
                    eventBox.querySelector('p:nth-of-type(2)').textContent = `Date: ${event.fecha_evento}`;
                }
            });
        })
        .catch(error => console.error('Error:', error));
});

// cargar la tabla de eventos:
document.getElementById('searchForm').addEventListener('submit', function(event) {
    event.preventDefault();
    var form = event.target;
    var params = new URLSearchParams(new FormData(form)).toString();

    fetch('cgi-bin/buscar_eventos.pl?' + params)
        .then(response => response.json())
        .then(data => {
            var tableBody = document.querySelector('#searchResults tbody');
            tableBody.innerHTML = '';

            data.forEach(event => {
                var row = document.createElement('tr');

                var idCell = document.createElement('td');
                idCell.textContent = event.id;
                row.appendChild(idCell);

                var tituloCell = document.createElement('td');
                tituloCell.textContent = event.titulo;
                row.appendChild(tituloCell);

                var descripcionCell = document.createElement('td');
                descripcionCell.textContent = event.descripcion;
                row.appendChild(descripcionCell);

                var tipoCell = document.createElement('td');
                tipoCell.textContent = event.tipo_evento;
                row.appendChild(tipoCell);

                var fechaEventoCell = document.createElement('td');
                fechaEventoCell.textContent = event.fecha_evento;
                row.appendChild(fechaEventoCell);

                var instalacionCell = document.createElement('td');
                instalacionCell.textContent = event.instalacion;
                row.appendChild(instalacionCell);

                tableBody.appendChild(row);
            });
        })
        .catch(error => console.error('Error:', error));
});

function checkSession() {
    var session = document.cookie.match(/^(.*;)?\s*session\s*=\s*[^;]+(.*)?$/);
    if (!session) {
        alert('Debe iniciar sesión para realizar un pedido.');
        window.location.href = 'index.html';
    }
}

function showPaymentDetails() {
    var metodoPago = document.getElementById("metodo_pago").value;
    var detallesTransferencia = document.getElementById("detalles_transferencia");
    var detallesYape = document.getElementById("detalles_yape");
    var otrosMetodos = document.getElementById("otros_metodos");

    detallesTransferencia.style.display = "none";
    detallesYape.style.display = "none";
    otrosMetodos.style.display = "none";

    if (metodoPago === "Transferencia") {
        detallesTransferencia.style.display = "block";
    } else if (metodoPago === "Yape") {
        detallesYape.style.display = "block";
    } else if (metodoPago === "Otros") {
        otrosMetodos.style.display = "block";
    }
}

window.onload = checkSession;
