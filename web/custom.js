(() => {
  if (window.flutter_web_plugins) {
    const platformViewRegistry = window.flutter_web_plugins.PlatformViewRegistry;
    platformViewRegistry.registerViewFactory('<iframeElement>', (viewId) => {
      const iframeElement = document.createElement('iframe');
      iframeElement.src = 'https://volle-power-mc.de:9000/';
      return iframeElement;
    });
  }
})();