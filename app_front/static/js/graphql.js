function requestData() {
    fetch('http://127.0.0.1:4000/api/graphiql', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
        },
        body: JSON.stringify({query: `{
            topLogs {
              pid
              user
              cpu
              memory
              time
              command
            }
          }`})
    })
    .then(r => r.json())
    .then(data => console.log('data returned:', data))
}

function data_to_html(top_log) {

}