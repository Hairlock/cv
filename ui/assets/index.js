function main() {
  require("../output/Main").main();
}

if (module.hot) {
  module.hot.dispose(function () {
    console.log("dispose");
  });

  module.hot.accept(function () {
    console.log("accept");
    document.body.innerHTML = ''
    main();
  });
}

// Fonts
import './fonts/*.*';

// Styles
import './styles/index.scss';

main();

const scroll = new SmoothScroll('a[href*="#"]');