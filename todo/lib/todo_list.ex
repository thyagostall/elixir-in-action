defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new, do: %TodoList{}

  def add_entry(%TodoList{entries: entries, auto_id: auto_id} = todo_list, entry) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = Map.put(entries, auto_id, entry)

    %TodoList{todo_list | entries: new_entries, auto_id: auto_id + 1}
  end

  def entries() do
  end

  def update_entry(%TodoList{} = todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, new_entry)
  end

  def update_entry(%TodoList{entries: entries} = todo_list, id, new_entry) do
    new_entries = %{entries | id => new_entry}
    %TodoList{todo_list | entries: new_entries}
  end

  def delete_entry(%TodoList{entries: entries} = todo_list, id) do
    entries = Map.delete(entries, id)
    %TodoList{todo_list | entries: entries}
  end
end
