<template>
  <div>
    <SearchBar></SearchBar>
    <div class="user-info">
      <div>
        <p>Username :</p>
        <p>UserId :</p>
        <p>Mail :</p>
        <p>Status :</p>
      </div>
      <div>
        <p class="userline">{{infoUserManager.surname}}</p>
        <p class="userline">{{infoUserManager.id}}</p>
        <p class="userline">{{infoUserManager.mail}}</p>
        <p class="userline" v-if="infoUserManager.status">Working</p>
        <p class="userline" v-if="!infoUserManager.status">Not working</p>
      </div>
      <div class="item-a pos-text">
        <b-button @click="setEmployee" v-b-modal.modal-prevent-closing-manager variant="outline-primary">Edit</b-button>

        <b-modal
          id="modal-prevent-closing-manager"
          ref="modalManager"
          title="our Name"
          @show="resetManager"
          @hidden="resetManager"
          @ok="handleOkManager"
        >
          <form ref="formManager" @submit.stop.prevent="handleSubmitManager">
            <b-form-group
              :state="nameStateManager"
              label="Surname"
              label-for="name-input"
              invalid-feedback="Surname is required"
            >
              <b-form-input
                v-model="tmpInfoUserManager.surname"
                id="name-input"
                :state="nameStateManager"
                required
              ></b-form-input>
            </b-form-group>
            <b-form-group
              :state="nameStateManager"
              label="Mail"
              label-for="mail-input"
              invalid-feedback="Mail is required"
            >
              <b-form-input v-model="tmpInfoUserManager.mail" id="mail-input" :state="mailStateManager" required></b-form-input>
            </b-form-group>
          </form>
        </b-modal>
      </div>
    </div>
  </div>
</template>

<script>
import SearchBar from "./../components/SearchBar";

export default {
  name: "userManager",
  components: { SearchBar },
  data() {
    return {
      nameStateManager: null,
      mailStateManager: null,
      submittedNames: [],
      info: null,
      infoUserManager: {
        surname: "test surname",
        mail: "test@mail.com",
        id: "2",
        status: false
      },
      tmpInfoUserManager: {
        surname: "",
        mail: "",
        id: "",
        status: false
      }
    };
  },
  methods: {
    checkFormValidity() {      
      const validNameManager = this.$refs.formManager.checkValidity();
      this.nameStateManager = validNameManager ? true : false;
      const validMailManager = this.validEmail(this.tmpInfoUserManager.mail);
      this.mailStateManager = validMailManager ? true : false;
      
      if (validMailManager && validNameManager) return true;
      return false;
    },
    resetManager() {
      this.mailStateManager = null;
      this.nameStateManagers = null;
    },
    handleOkManager(bvModalEvt) {
      // Prevent modal from closing
      bvModalEvt.preventDefault();
      // Trigger submit handler
      this.handleSubmitManager();
    },
    handleSubmitManager() {
      
      // Exit when the form isn't valid
      if (!this.checkFormValidity()) {
        return;
      }
      this.infoUserManager.mail = this.tmpInfoUserManager.mail;
      this.infoUserManager.surname = this.tmpInfoUserManager.surname;
      
      // Hide the modal manually
      
      this.$nextTick(() => {
        this.$refs.modalManager.hide();
      });
    },
    setEmployee() {
      
      this.tmpInfoUserManager.surname = this.infoUserManager.surname;
      this.tmpInfoUserManager.mail = this.infoUserManager.mail;
      
    },
    validEmail: function(email) {
      var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(email);
    }
  }
};
</script>



<style scoped>
.color-choice {
  margin-top: 30px;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: 30px;
  display: block;
}

.pos-text {
  display: block;
  margin: auto;
}

.item-a {
  grid-column: span 2;
  grid-row: 2;
}

.user-info {
  padding: 20px;
  display: grid;
  grid-template-columns: 30% 65%;
  grid-gap: 20px;
  margin: 0 auto;
  width: 80%;
}

.userline {
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
}

.center * {
  text-align: center;
}
</style>