defmodule TodoListTest do
  use ExUnit.Case
  doctest Todo

  test "An empty todo list" do
    result = TodoList.new

    assert %TodoList{auto_id: 1, entries: %{}} == result
  end

  test "Adding to the todo list" do
    item = create_todo_list_item()
    processed_item = item |> add_id_to_todo_list_item(1)
    entries = %{1 => processed_item}

    todo_list = TodoList.new |> TodoList.add_entry(item)

    assert %TodoList{auto_id: 2, entries: entries} == todo_list
  end

  test "Updating a todo list item in the list" do
    item = create_todo_list_item()

    todo_list = TodoList.new |> TodoList.add_entry(item)

    updated_item = %{item | title: "Updated entry"}
    entries = %{1 => updated_item}

    todo_list = todo_list |> TodoList.update_entry(1, updated_item)

    assert %TodoList{auto_id: 2, entries: entries} == todo_list
  end

  test "Updating a todo list item without passing the id to the function" do
    item = create_todo_list_item_with_id()

    todo_list = TodoList.new |> TodoList.add_entry(item)

    updated_item = %{item | title: "Updated entry"}
    entries = %{1 => updated_item}

    todo_list = todo_list |> TodoList.update_entry(updated_item)

    assert %TodoList{auto_id: 2, entries: entries} == todo_list
  end

  test "Deleting a todo list item using its id" do
    item = create_todo_list_item_with_id()

    todo_list = TodoList.new
    |> TodoList.add_entry(item)
    |> TodoList.delete_entry(1)

    assert %TodoList{auto_id: 2, entries: %{}} == todo_list
  end

  test "retrieve created entries filtering by date" do
    todo_list = TodoList.new
    |> TodoList.add_entry(create_todo_list_item())
    |> TodoList.add_entry(create_todo_list_item())
    |> TodoList.add_entry(create_todo_list_item_with_date({2016, 1, 1}))
    |> TodoList.add_entry(create_todo_list_item())

    assert 3 == todo_list |> TodoList.entries({2017, 1, 1}) |> Enum.count
  end

  defp create_todo_list_item do
    %{date: {2017, 01, 01}, title: "My entry"}
  end

  defp create_todo_list_item_with_date(date) do
    %{date: date, title: "My entry"}
  end

  defp create_todo_list_item_with_id do
    %{id: 1, date: {2017, 01, 01}, title: "My entry"}
  end

  defp add_id_to_todo_list_item(%{} = item, id) do
    Map.merge(item, %{id: id})
  end
end
