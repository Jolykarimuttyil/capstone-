/* global Vue, VueRouter, axios */
var HomePage = {
  template: "#home-page",
  data: function() {
    return {};
  },
  created: function() {},
  methods: {},
  computed: {}
};

var RecipesIndexPage = {
  template: "#recipes-index-page",
  data: function() {
    return {
      recipes: [],
    };
  },
  created: function() {
    axios.get("/v1/recipes").then(
      function(response) {
        this.recipes = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var RecipesCreatePage = {
  template: "#recipes-create-page",
  data: function() {
    return {
      name: "",
      
    };
  },
  created: function() {},
  methods: {
    submit: function() {
      var params = {
        input_name: this.name
      };
      axios
        .post("/v1/recipes", params)
        .then (function(response) {
          router.push("/");

        });
    }
  },
  computed: {}
};






var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/recipes", component: RecipesIndexPage },
    { path: "/create-recipes", component: RecipesCreatePage},
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router
});


 




  