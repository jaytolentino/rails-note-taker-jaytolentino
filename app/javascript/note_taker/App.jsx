import "./App.css";

import {
  faCalendarCheck,
  faEdit,
  faSave,
  faSearch,
  faTimesCircle,
} from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import React, { useEffect, useState } from "react";

const getCsrf = () =>
  document
    .querySelectorAll('meta[name="csrf-token"]')[0]
    .getAttribute("content");

function saveNote(url = "", data = {}) {
  if (data.id) {
    return fetch(url + data.id, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": getCsrf(),
      },
      body: JSON.stringify(data),
    });
  }
  return fetch(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": getCsrf(),
    },
    body: JSON.stringify(data),
  });
}

function deleteNote(url = "") {
  return fetch(url, {
    method: "DELETE",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": getCsrf(),
    },
  });
}

function getNotes(url, searchString) {
  const requestUrl =
    url +
    (searchString && searchString.length
      ? `?query=${encodeURI(searchString)}`
      : "");
  return fetch(requestUrl);
}

function App() {
  const [newNote, setNewNote] = useState("");
  const [newReminder, setReminder] = useState("");
  const [notes, setNotes] = useState([]);
  const [searchString, setSearchString] = useState("");

  useEffect(() => {
    getNotes("http://127.0.0.1:3000/notes", searchString)
      .then((response) => response.json())
      .then((data) => {
        setNotes(data);
      });
  }, [searchString]);

  const handleSetNewNote = (e) => {
    setNewNote(e.currentTarget.value);
  };

  const handleSetReminder = (e) => {
    setReminder(e.currentTarget.value);
  };

  const handleSetSearchString = (e) => {
    setSearchString(e.currentTarget.value);
  };

  const handleSetSelectedNoteTitle = (note) => (e) => {
    const updatedNote = { ...note, title: e.currentTarget.value };
    for (let i = 0; i < notes.length; i += 1) {
      if (notes[i].id === updatedNote.id) {
        notes[i] = updatedNote;
        break;
      }
    }
    setNotes([...notes]);
  };

  const handleSave = (e) => {
    e.preventDefault();
    const newNoteValue = {
      title: newNote,
    };

    if (newReminder.length > 0) {
      newNoteValue.scheduled_at = new Date(newReminder).toISOString();
    }

    setNewNote("");
    setReminder("");

    saveNote("http://127.0.0.1:3000/notes", newNoteValue)
      .then((response) => response.json())
      .then((data) => {
        if (data.errors) {
          console.log(data.errors);
          return;
        }
        setNotes([...notes, data]);
      });
  };

  const handleSaveSelectedNote = (selectedNote) => (e) => {
    e.preventDefault();

    saveNote("http://127.0.0.1:3000/notes/", selectedNote)
      .then((response) => response.json())
      .then((data) => {
        if (data.errors) {
          console.log(data.errors);
        }
      });
  };

  const handleSearch = (e) => {
    e.preventDefault();
    getNotes("http://127.0.0.1:3000/notes", searchString)
      .then((response) => response.json())
      .then((data) => {
        setNotes(data);
      });
  };

  const handleDelete = (id) => () => {
    deleteNote(`http://127.0.0.1:3000/notes/${id}`).then(() => {
      const filteredNotes = notes.filter((note) => note.id !== id);
      setNotes(filteredNotes);
    });
  };

  return (
    <div className="App">
      <h1>Note Taker</h1>
      <form id="NewNoteForm" className="New-Note" onSubmit={handleSave}>
        <input
          name="newNote"
          placeholder="New Note Title"
          autoComplete="off"
          value={newNote}
          onChange={handleSetNewNote}
        />
        <input
          type="datetime-local"
          id="reminder"
          name="reminder"
          value={newReminder}
          onChange={handleSetReminder}
        />
        <button type="submit">
          <FontAwesomeIcon
            icon={faSave}
            size="2x"
            style={{ color: "#eeeeee" }}
          />
        </button>
      </form>
      <form
        id="SearchNotesForm"
        className="Search-Notes"
        onSubmit={handleSearch}
      >
        <input
          name="searchString"
          placeholder="Search String"
          autoComplete="off"
          value={searchString}
          onChange={handleSetSearchString}
        />
        <button type="submit">
          <FontAwesomeIcon
            icon={faSearch}
            size="2x"
            style={{ color: "#eeeeee" }}
          />
        </button>
      </form>
      <div className="Notes">
        {notes.map((note) => (
          <div key={note.id} className="Note">
            <input
              value={note.title}
              autoComplete="off"
              onChange={handleSetSelectedNoteTitle(note)}
            />
            <button type="button">
              <FontAwesomeIcon
                icon={faCalendarCheck}
                size="2x"
                style={{ color: note.scheduled_at ? "#4ecca3" : "#eeeeee" }}
              />
            </button>
            <button type="button" onClick={handleSaveSelectedNote(note)}>
              <FontAwesomeIcon
                icon={faEdit}
                size="2x"
                style={{ color: "#eeeeee" }}
              />
            </button>
            <button type="button" onClick={handleDelete(note.id)}>
              <FontAwesomeIcon
                icon={faTimesCircle}
                size="2x"
                style={{ color: "#eeeeee" }}
              />
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;
