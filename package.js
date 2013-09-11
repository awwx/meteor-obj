Package.describe({
  summary: "Easily create plain objects with computed keys"
});

Package.on_use(function (api) {
  api.use(["coffeescript"], ["client", "server"]);
  api.export("obj");
  api.add_files("obj.coffee", ["client", "server"]);
});

Package.on_test(function (api) {
  api.use(["coffeescript", "obj", "tinytest"], ["client", "server"]);
  api.add_files("obj-test.coffee", ["client", "server"]);
});
