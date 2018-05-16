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
        .then(function(response) {
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

var RecipesShowPage = {
  template: "#recipes-show-page",
  data: function() {
    return {
      recipe: {},
      

    };
  },
  created: function() {
    console.log("RecipesShowPage created");
    // axios.get("/v1/recipes_show?recipe_url=" + this.$route.query.recipe_url).then(
    //   function(response) {
    //     this.recipe = response.data;
    //     console.log(this.recipe);
    //   }.bind(this)
    // );
    this.recipe = JSON.parse(localStorage.getItem("recipe"));
    console.log('recipe', this.recipe);
  },
  methods: {

  },
  computed: {}
};


var RecipesSearchPage = {
  template: "#recipes-search-page",
  data: function() {
    return {
      recipes:[],
      ingredients: "",
      min_calories: null,
      max_calories: null,
      diet_restrictions: "",
      max_ingredients: null,
      excluded: "",
      currentRecipe: {},
      
    };
  },
  created: function() {},
  methods: {
    viewRecipe: function(recipe) {
      localStorage.setItem('recipe', JSON.stringify(recipe));
      router.push("/recipes_show");
    },
    setCurrentRecipe: function(inputRecipe) {
      this.currentRecipe = inputRecipe;
    },
    submit: function() {
      var params = {
        ingredients: this.ingredients,
        min_calories: this.min_calories || 200,
        max_calories: this.max_calories || 1000,
        max_ingredients: this.max_ingredients || 50,
        excluded: this.excluded 
      };
      if (this.diet_restrictions) {
        params.diet_restrictions = this.diet_restrictions;
      }
      axios
        .get("/v1/recipes_search", {params: params})
        .then(function(response) {
          console.log('search response', response.data);
          this.recipes = response.data.hits;
        }.bind(this));
    }

  },
};









var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/recipes", component: RecipesIndexPage },
    { path: "/recipes_show", component: RecipesShowPage },
    { path: "/create_recipes", component: RecipesCreatePage},
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/fridge_create", component: FridgeItemCreatePage},
    { path: "/fridge_index", component: FridgeIndexPage },
    { path: "/recipes_search", component: RecipesSearchPage }
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


 




  