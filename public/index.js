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
      ingredients: [{name: ""}, {name: ""}, {name: ""}, {name: ""}, {name: ""}],
      directions: [{text: ""}, {text: ""}, {text: ""}, {text: ""}, {text: ""}]
    };
  },
  created: function() {},
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        ingredients: this.ingredients.filter(ingredient => ingredient.name).map(ingredient => ingredient.name),
        directions: this.directions.filter(direction => direction.text).map(direction => direction.text)
      };
      axios
        .post("/v1/recipes", params)
        .then (function(response) {
          console.log("created recipe", response);
          router.push("/");

        });
    }

  },
  computed: {}
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "joe@email.com",
      password: "password",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var FridgeItemCreatePage = {
  template: "#fridge-item-create-page",
  data: function() {
    return {
      name: "",
      
      
    };
  },
  created: function() {},
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        

        
      };
      axios
        .post("/v1/fridge_items", params)
        .then(function(response) {
          router.push("/");

        });
    }

  }
};

var FridgeIndexPage = {
  template: "#recipes-index-page",
  data: function() {
    return {
      fridgeItems: [],
    };
  },
  created: function() {
    axios.get("v1/fridge_items").then(
      function(response) {
        this.recipes = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};


var RecipesSearchPage = {
  template: "#recipes-search-page",
  data: function() {
    return {
      recipes: [],
    
    };
  },
  created: function() {
    axios.get("/v1/recipes_search").then(
      function(response) {
        this.recipes = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};







var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/recipes", component: RecipesIndexPage },
    { path: "/create-recipes", component: RecipesCreatePage},
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/fridge-create", component: FridgeItemCreatePage},
    { path: "/fridge-index", component: FridgeIndexPage },
    { path: "/recipe-search", component: RecipesSearchPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});


 




  