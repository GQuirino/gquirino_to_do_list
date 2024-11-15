export const FETCH_ALL_TODO_QUERY = (filterBy) => `
  query {
    todos(status: "${filterBy}") {
      id
      title
      description
      status
    }
  }
`

export const FETCH_TODO_QUERY = (itemId) => `
  query {
    todo(id: "${itemId}") {
      id
      title
      description
      status
    }
  }
`
