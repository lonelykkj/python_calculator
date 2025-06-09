import customtkinter as ctk

ctk.set_appearance_mode("dark")


# function to verify login credentials
def login_verification():
    username = entry_user.get()
    password = entry_password.get()

    if username == "admin" and password == "password":
        login_result.configure(text="Login successful!", text_color="green")
    else:
        login_result.configure(text="Login failed! Try again.", text_color="red")


app = ctk.CTk()
app.title("CustomTkinter App")
app.geometry("400x400")

# username label and entry

label_user = ctk.CTkLabel(
    app,
    text="User",
    font=("JetBrains Mono", 15),
    text_color="white",
)
label_user.pack(pady=10)

entry_user = ctk.CTkEntry(app, placeholder_text="Enter your username", width=200)
entry_user.configure(font=("JetBrains Mono", 15), text_color="white")
entry_user.pack(pady=10)

# password label and entry

label_password = ctk.CTkLabel(
    app,
    text="Password",
    font=("JetBrains Mono", 15),
    text_color="white",
)
label_password.pack(pady=10)

entry_password = ctk.CTkEntry(app, placeholder_text="Enter your username", width=200)
entry_password.configure(font=("JetBrains Mono", 15), text_color="white", show="*")
entry_password.pack(pady=10)

# button to submit
ctk.CTkButton(app, text="Login", command=login_verification).pack(pady=20)

# feedback label
login_result = ctk.CTkLabel(app, text="")
login_result.pack(pady=10)

app.mainloop()
