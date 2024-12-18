"use client";

import LoginForm from "@/components/auth/login-form";
import StickyNote from "@/components/sticky-note";
import { useState } from "react";

const LoginPage = () => {
  const [notes1, setNotes1] = useState([{ id: 1, content: "Your note content here" }]);
  const handleClose1 = (noteId: number) => {
    setNotes1(notes1.filter(note => note.id !== noteId));
  };

  const [notes2, setNotes2] = useState([{ id: 1, content: "Your note content here" }]);
  const handleClose2 = (noteId: number) => {
    setNotes2(notes2.filter(note => note.id !== noteId));
  };

  const [notes3, setNotes3] = useState([{ id: 1, content: "Your note content here" }]);
  const handleClose3 = (noteId: number) => {
    setNotes3(notes3.filter(note => note.id !== noteId));
  }
  return (
    <main className="h-screen bg-purple-100 flex flex-row">

      {notes1.map((note) => (
        <StickyNote
          key={note.id}
          initialPos={{ x: 100, y: 100 }}
          color="red"
          onClose={() => handleClose1(note.id)}
        >
          <div>
            <div className="font-bold text-lg pb-1 border-b border-black/30">SUPER ADMIN USER</div>
            <div className="pt-2 font-semibold">USERNAME:</div>
            <div> superadmin@gmail.com</div>
            <div className="font-semibold">PASSWORD:</div>
            <div>superadminPassword</div>
          </div>
        </StickyNote>
      ))}

      {notes2.map((note) => (
        <StickyNote
          key={note.id}
          initialPos={{ x: 100, y: 400 }}
          color="blue"
          onClose={() => handleClose2(note.id)}
        >
          <div>
            <div className="font-bold text-lg pb-1 border-b border-black/30">ADMIN USER</div>
            <div className="pt-2 font-semibold">USERNAME:</div>
            <div> admin@gmail.com</div>
            <div className="font-semibold">PASSWORD:</div>
            <div>adminPassword</div>
          </div>
        </StickyNote>
      ))}

      {notes3.map((note) => (
        <StickyNote
          key={note.id}
          initialPos={{ x: 100, y: 700 }}
          color="violet"
          onClose={() => handleClose3(note.id)}
        >
          <div>
            <div className="font-bold text-lg pb-1 border-b border-black/30">USER</div>
            <div className="pt-2 font-semibold">USERNAME:</div>
            <div> user@gmail.com</div>
            <div className="font-semibold">PASSWORD:</div>
            <div>userPassword</div>
          </div>
        </StickyNote>
      ))}
      <div className="h-screen w-full bg-gradient-to-t from-purple-500 to-purple-700 flex flex-col gap-2 items-center justify-center">
        <LoginForm />
      </div>
    </main>
  )
};

export default LoginPage;
