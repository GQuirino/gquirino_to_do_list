window.onload = function() {
  //<editor-fold desc="Changeable Configuration Block">
  console.log(window)
  const apiHost = `${window.location.protocol}//${window.location.host}` || 'http://localhost:3000';

  // the following lines will be replaced by docker/configurator, when it runs in a docker-container
  window.ui = SwaggerUIBundle({
    url: `${apiHost}/api/swagger_doc`,
    dom_id: '#swagger-ui',
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout"
  });

  //</editor-fold>
};
