<script setup>
import { ref, onMounted, onUpdated } from 'vue';
const todos = ref([]);
const API_URL = 'http://127.0.0.1:3000/todos';
const title = ref();
const body = ref();
const status = ref(false);
const todo_id = ref(0);
const isEditing = ref(false);

const index = async () => {
  const res = await fetch(API_URL, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  })
  todos.value = await res.json();
}

const createTodo = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      title: title.value,
      body: body.value,
      status: status.value,
    })
  })

  const data = await res.json();
  todos.value.push(data);
  title.value = '';
  body.value = '';
  todo_id.value = 0;
}

const deleteTodo = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE',
  })

  todos.value = todos.value.filter((todo) => {
    todo.id !== id;
  })
}

const editTodo = (todo) => {
  isEditing.value = true;
  title.value = todo.title;
  body.value = todo.body;

  todo_id.value = todo.id;

  window.scrollTo({
    top: 0,
    behavior: 'smooth',
  })
}

const updateTodo = async () => {
  await fetch(`${API_URL}/${todo_id.value}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      id: todo_id.value,
      title: title.value,
      body: body.value,
      status: status.value,
    })
  })
}

const cancelBtn = () => {
  title.value = '';
  body.value = '';
  todo_id.value = 0;
  isEditing.value = false;
}

onMounted(() => {
  index();
})

onUpdated(() => {
  index();
})
</script>

<template>
  <div class="parent-container">
    <div class="dy-container">
      <h2>Create a Todo</h2>
      <input type="text" v-model="title" class="title-input" placeholder="Title...">
      <input type="text" v-model="body" class="body-input" placeholder="Description...">
      <div class="action-btns">
        <button v-if="!isEditing" @click="createTodo" :disabled="!title">Create</button>
        <button v-if="isEditing" @click="updateTodo">Update</button>
        <button v-if="isEditing" @click="cancelBtn">Cancel</button>
      </div>
    </div>
  
    <div class="list-container">
      <h2>My Todos:</h2>
      <div class="list-items">
        <div v-for="todo in todos" class="list-item">
          <p>{{ todo.title }}</p>
          <p>{{ todo.body }}</p>
          <div class="item-btns">
            <button @click="editTodo(todo)">Edit</button>
            <button @click="deleteTodo(todo.id)">Delete</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.parent-container {
  display: grid;
  grid-template-columns: repeat(2, 600px);
  gap: 5rem;
  margin-block: 3rem;
}

.dy-container {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-direction: column;
  gap: 1rem;
}

.title-input{
  width: 80%;
  padding: 12px 20px;
  box-sizing: border-box;
  border: 1px solid purple;
  border-radius: 4px;
}
.body-input {
  width: 80%;
  padding: 10px 20px;
  box-sizing: border-box;
  border: 1px solid purple;
  border-radius: 4px;
  height: 3rem;
}
.action-btns {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
}
.list-container {
  display: flex;
  justify-content: flex-start;
  align-items: flex-start;
  flex-direction: column;
}

button {
  border-color: purple;
}

.list-items {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  gap: 1.2rem;
}

.list-item {
  border: 1px solid lightcyan;
  padding: 1.2rem 2rem;
  border-radius: 1rem;
  cursor: pointer;
  width: 450px;
  border-color: purple;
  background-color: #3B3B3B;
}
.item-btns {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  gap: .6rem;
}
</style>