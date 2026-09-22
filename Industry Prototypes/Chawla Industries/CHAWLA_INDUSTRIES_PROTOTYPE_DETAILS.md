# Chawla Industries — Prototype Details

**Product:** Chawla Machines — Business Management App (Prototype)
**Client:** Chawla Industries, Ahmedabad (packaging machinery, since 1989)
**Prepared by:** Sangam InfoAnalytics
**Type:** Interactive demonstration prototype (single-file web app)

---

## 12. Executive Summary (read this first — 30 to 60 seconds)

Chawla Industries manufactures packaging machines. Today, machine videos,
customer phone numbers, enquiries, quotations and money records are usually
spread across WhatsApp chats, the phone gallery, notebooks and memory. Things
get lost, follow-ups slip, and the phone fills up with heavy videos.

This prototype shows **one app that holds the whole business in a single place**:

- A **machine catalogue** with video, photos and specifications
- A **one-tap way to send a machine** to a customer on WhatsApp or e-mail (as a
  link, not a heavy file)
- An **enquiry register** that tracks every customer from first call to final
  sale
- A **quotation screen with automatic GST calculation** and amount in words
- A **money book** for sales, purchases, income and expenses, with reports
- A **customer-facing page** (with a Gujarati / English toggle) where the
  customer can watch the machine and send an enquiry back

Tap through it exactly as the staff would: send a machine, see the enquiry come
back, make the quotation, record the sale, and view the report for any period.

> **Please note:** This is a working *prototype* built to demonstrate the layout,
> experience and workflow. It uses sample data and does not yet save anything.
> The final application will be built to Chawla Industries' exact requirements.

---

## 1. Prototype Objective

**What this application is designed to achieve**
To give a machine manufacturer one simple mobile app that manages the complete
customer journey — from showing a machine, to handling the enquiry, to sending a
GST quotation, to recording the sale and seeing the profit.

**The main business problem it solves**
Right now the important parts of the business live in different places: videos in
the phone gallery, numbers in WhatsApp, enquiries in the owner's head, quotations
in a separate calculator or Word file, and money in a paper book. This is slow,
easy to lose, and hard to review. The app brings all of it together.

**Why Chawla Industries would use it**
- Send any machine to any customer in two taps, without filling up the phone.
- Never lose an enquiry or forget a follow-up.
- Make a clean, GST-correct quotation on the phone in minutes.
- See sales, expenses and profit for today, this week, this month or this year.
- Give customers a professional page to view machines and enquire — in Gujarati
  or English.

---

## 2. Who Can Use It

The prototype is designed around a small manufacturing business team. The
following roles are the intended users:

- **Business Owner** — sees everything: catalogue, enquiries, quotations, money
  and reports. The main decision-maker.
- **Sales Team / Sales Staff** — send machines to customers, log enquiries,
  update follow-up stages, and make quotations.
- **Office / Admin Staff** — add machines, maintain the customer list, record
  entries in the money book.
- **Accounts Team** — use the money book, reports and GST summary; the "Send to
  my CA" action is meant for sharing figures with the accountant.
- **Management** — use the reports and KPIs (sales, purchases, profit) to review
  performance.
- **Customers** — use only the public customer-facing page: watch the machine
  video, see photos and specifications, and send an enquiry.

> In this prototype there is a single demo login and everyone sees the same
> screens. Separate user accounts and role-based permissions are a
> **future production** item (see Section 10).

---

## 3. Main Use Cases

Each item below is something the prototype actually demonstrates on screen:

- **Machine / product catalogue** — a scrollable list of machines, each with
  artwork, video length, number of photos, a "catalog PDF" tag, a price (or
  "Price on request"), a Send button, and a "watched" count. A search box filters
  the list by name.
- **Customer management** — a saved list of customers with name, city, phone and
  total business value; add, open and remove customers.
- **Customer enquiries** — an enquiry register that lists every enquiry with the
  customer, the machine, the city and the current stage.
- **Follow-ups** — each enquiry carries a stage (New, Video sent, Quote sent,
  Won, Lost) and a "follow up today" counter, so nothing is forgotten.
- **Machine sharing** — a "Send to customer" flow: choose WhatsApp or e-mail,
  pick the customer, and the machine goes out as a link. The app shows a "SENT"
  confirmation and automatically creates the matching enquiry.
- **Quotations** — a quotation screen where you pick the customer, add machines
  with quantity and rate, add freight, and choose the GST rate.
- **GST calculation** — the quotation automatically splits GST into CGST and SGST
  and shows the grand total and the amount in words (Indian format).
- **Sales / billing** — sales are recorded in the money book and roll up into the
  reports and the customer's profile.
- **Money / book management** — a day book of money in and money out, with recent
  entries.
- **Income & expense tracking** — four entry types: Sale, Purchase, Income and
  Expense.
- **Reports** — sales, purchases, other income, expenses, net profit, a
  sales-vs-purchase chart and a GST summary, for the chosen period.
- **Customer-facing catalogue** — a public page (a simulated link) where the
  customer sees the machine and can send an enquiry back.
- **Gujarati / customer communication** — the customer page has a one-tap
  Gujarati ⇄ English toggle for the labels and the enquiry form.
- **Activity tracking** — a "Who watched" feed showing which customer opened or
  watched which machine, and how much of the video they watched.

---

## 4. Complete Workflow

The prototype is built to walk through this end-to-end business flow:

```
Machine Catalogue
      │
      ▼
Customer Views Machine   (owner opens machine detail / customer opens the link)
      │
      ▼
Machine Shared           (Send to customer → WhatsApp or e-mail, as a link)
      │
      ▼
Customer Enquiry         (enquiry auto-created, or customer submits the form)
      │
      ▼
Follow-up                (enquiry stage updated: New → Video sent → …)
      │
      ▼
Quotation                (pick customer + machines, add freight)
      │
      ▼
GST Calculation          (CGST + SGST split, total, amount in words)
      │
      ▼
Quotation Sharing        (Send on WhatsApp → enquiry moves to "Quote sent")
      │
      ▼
Sale / Billing           (recorded as a Sale entry in the money book)
      │
      ▼
Payment                  (reflected in money in / net; 50% advance term shown)
      │
      ▼
Money Book               (sales, purchases, income, expenses in one ledger)
      │
      ▼
Reports                  (sales, profit, GST summary for day/week/month/year)
```

Every step in this chain has a corresponding screen in the prototype, and the
steps connect to each other (for example, sending a machine creates an enquiry,
and sending a quotation moves that enquiry to the "Quote sent" stage).

---

## 5. Module-by-Module Explanation

### 5.1 Login
- **Objective:** Open the business securely on the phone.
- **Who uses it:** Every internal user.
- **Problem it solves:** A single entry point to the business.
- **Functionality (in the prototype):** A mobile-number and OTP screen. For the
  demo both fields are pre-filled and the button simply opens the app.
- **How it helps:** Sets up the idea of a private, owner-controlled app.
- *Real login and OTP are a future production item.*

### 5.2 Machines (Catalogue)
- **Objective:** Show all machines in one organised list.
- **Who uses it:** Owner, sales, admin.
- **Problem it solves:** Videos and details are no longer scattered in the
  gallery and chats.
- **Functionality:** List of machines with artwork, video length, photo count,
  catalog-PDF tag, price or "Price on request", a Send button and a "watched"
  count. A search box filters by machine name. A storage gauge and quick buttons
  for "Add machine" and "Who watched" sit at the top.
- **How it helps:** Anything can be found and sent in seconds.

### 5.3 Machine Detail
- **Objective:** Show one machine fully.
- **Who uses it:** Owner, sales.
- **Problem it solves:** Gives a complete, professional view of a single machine.
- **Functionality:** Video area with a play button and progress bar (simulated
  playback), machine name, price, a photo gallery, a catalog-PDF card, and a
  specifications table. Buttons to "Preview as customer" and "Send to customer",
  plus a copy-link button.
- **How it helps:** One screen has everything needed to pitch a machine.

### 5.4 Send (Sharing Sheet)
- **Objective:** Send a machine to a customer.
- **Who uses it:** Owner, sales.
- **Problem it solves:** Removes the manual work of finding a video and a
  contact and forwarding a heavy file.
- **Functionality:** Choose WhatsApp or e-mail, then pick a customer from the
  list. The app plays a "SENT" confirmation and automatically adds the enquiry
  and an activity entry.
- **How it helps:** Two taps to share, and the enquiry is logged for you.

### 5.5 Enquiry Register
- **Objective:** Track every customer enquiry in one list.
- **Who uses it:** Owner, sales.
- **Problem it solves:** Enquiries and follow-ups stop slipping through the
  cracks.
- **Functionality:** Header counters (Open, Won this month, Follow up today),
  filter pills by stage with live counts, and a row for each enquiry. Opening an
  enquiry lets you change its stage, call the customer, send the video again, or
  make a quotation. A "+" button logs a new enquiry (customer, machine, note).
- **How it helps:** The whole sales pipeline is visible at a glance.

### 5.6 Quotation & GST
- **Objective:** Make a correct quotation quickly.
- **Who uses it:** Owner, sales, accounts.
- **Problem it solves:** No more manual GST maths or separate calculators.
- **Functionality:** Pick the customer, add machine lines (quantity and rate),
  add freight, and choose the GST rate (18% / 12% / 28%). The app shows sub
  total, freight, CGST, SGST, grand total and the amount in words. A footer line
  shows the sample GSTIN, HSN code, delivery time and the 50% advance term.
  Buttons to save the PDF and to send on WhatsApp (which moves the enquiry to
  "Quote sent").
- **How it helps:** A clean, tax-correct quotation from the phone in minutes.

### 5.7 Money Book — Day Book
- **Objective:** Record all money movement.
- **Who uses it:** Owner, accounts, admin.
- **Problem it solves:** Replaces the paper cash book.
- **Functionality:** Money in and money out for the month, the net figure, and a
  list of recent entries. A "+" button adds an entry as Sale, Purchase, Income or
  Expense.
- **How it helps:** One running ledger of the whole business.

### 5.8 Money Book — Reports
- **Objective:** See the numbers that matter.
- **Who uses it:** Owner, management, accounts.
- **Problem it solves:** No more guessing whether the month was good.
- **Functionality:** Period pills (Today / This week / This month / This year),
  KPIs for sales, purchases, other income and expenses, a net-profit figure, a
  sales-vs-purchase bar chart, and a GST summary (taxable value, CGST, SGST, tax
  collected) with a "Send to my CA" action.
- **How it helps:** Clear financial visibility for any period.

### 5.9 Customers
- **Objective:** Keep all customers in one place.
- **Who uses it:** Owner, sales, admin.
- **Problem it solves:** Contacts are no longer lost in the phone.
- **Functionality:** A searchable list with name, city, phone and total business
  value, a saved-count, and a "+" button to add a customer (name, phone, city,
  e-mail).
- **How it helps:** Every customer is one tap away.

### 5.10 Customer Profile
- **Objective:** See one customer's full history.
- **Who uses it:** Owner, sales.
- **Problem it solves:** All of a customer's dealings in one view.
- **Functionality:** KPIs for total business and number of enquiries, a list of
  their enquiries with stages, a list of their bills, and actions to call, send a
  machine, or remove the customer.
- **How it helps:** Prepares you before every call.

### 5.11 More
- **Objective:** A shortcut menu to the rest of the app.
- **Who uses it:** All internal users.
- **Functionality:** Tiles for Add a machine, Quotation & GST, Who watched,
  Customer view, Reports and Backup.
- **How it helps:** Fast access to secondary features.

### 5.12 Customer View (Public Link)
- **Objective:** Show the machine to the customer and collect an enquiry.
- **Who uses it:** Customers.
- **Problem it solves:** Gives the customer a clean, branded page instead of a
  forwarded file.
- **Functionality:** A simulated browser link, a Gujarati / English toggle, the
  machine video, name, price, photo gallery, catalog-PDF card, specifications,
  and an enquiry form (name, mobile, city, requirement). Submitting the form
  creates the customer and the enquiry automatically.
- **How it helps:** Turns a shared link into a real, tracked lead.

### 5.13 Activity ("Who Watched")
- **Objective:** Show who is engaging with shared machines.
- **Who uses it:** Owner, sales.
- **Problem it solves:** You know who is genuinely interested.
- **Functionality:** A live-style feed of who opened, watched or downloaded a
  machine, including how much of the video was watched.
- **How it helps:** Follow up the warmest leads first.

### 5.14 Add a Machine (Upload)
- **Objective:** Add a new machine by picking a video.
- **Who uses it:** Owner, admin.
- **Problem it solves:** Adding a machine should be as easy as picking a video.
- **Functionality:** A "pick video" area that shows an upload progress ring and
  then a "made small for mobile" step, and updates the phone-storage gauge.
- **How it helps:** Demonstrates that heavy videos are handled for you and do not
  clog the phone.

---

## 6. Customer Side

The prototype includes a dedicated **customer-facing page** (the public link)
that a customer would open. It shows:

- **A public machine / product page** styled like a real web link
  (`chawla.link/...`).
- **Photos** — a gallery of the machine.
- **Video** — a play button and progress bar (simulated in the prototype).
- **Specifications** — the machine's technical details.
- **Catalogue PDF** — a catalog card the customer can tap.
- **Enquiry form** — name, mobile number, city and requirement; submitting it
  sends the enquiry straight into the owner's register.
- **Gujarati / English experience** — a one-tap language toggle that switches the
  page labels and the enquiry form between English and Gujarati.
- **Shareable link** — the whole page is presented as a single link that can be
  sent on WhatsApp or e-mail.

This is the experience the owner is selling: the customer receives a neat,
professional page rather than a heavy forwarded video.

---

## 7. Business Benefits

- **Centralised business management** — machines, customers, enquiries,
  quotations and money in one app.
- **Faster enquiry handling** — every enquiry is captured and visible.
- **Better follow-up** — clear stages and a "follow up today" counter.
- **Professional quotations** — clean quotations with correct GST and amount in
  words.
- **GST calculation** — CGST / SGST split handled automatically.
- **Better customer management** — a searchable customer list with full history.
- **Sales visibility** — the sales pipeline is visible from first call to sale.
- **Financial visibility** — profit, sales, purchases and expenses for any
  period.
- **Reduced manual work** — sending a machine also logs the enquiry; sending a
  quotation updates the stage.
- **Better reporting** — period reports, a sales-vs-purchase chart and a GST
  summary.
- **Better customer experience** — a branded, bilingual page that makes the
  business look organised and modern.

---

## 8. Suitable Businesses / Clients

This type of system fits any business that shows products, handles enquiries and
raises quotations. It is an especially strong fit for:

- **Machine manufacturers**
- **Industrial machinery manufacturers**
- **Machinery dealers**
- **Engineering companies**
- **Manufacturing businesses**
- **Equipment suppliers**
- **B2B product businesses**

**How the same concept adapts to other industries**
The core idea — a product catalogue with media, a shareable customer page, an
enquiry pipeline, quotations with tax, and a money book — can be reused with
small changes for other sectors, for example: building materials and hardware
suppliers, furniture and interior businesses, auto-parts and spare-parts dealers,
agricultural equipment sellers, electronics and appliances distributors, and any
dealer or manufacturer who sells to other businesses. Only the catalogue content,
the terminology and the tax rules would change.

---

## 9. Prototype vs Actual Application

> **This is a prototype created to demonstrate the proposed application
> structure, user experience, workflow and functionality. It is not the final
> production application.**

The prototype runs on sample data and is meant for showing and discussing the
idea. In particular, the following are **demonstration behaviours** in the
prototype and are **not yet real**:

- **No real login** — the OTP is pre-filled; the button just opens the app.
- **No saved data** — everything is sample data held in memory; refreshing the
  page resets it.
- **No real sending** — the WhatsApp / e-mail "Send" and quotation "Send" show a
  confirmation animation and message, but nothing is actually sent.
- **No real files** — the catalog PDF, the quotation PDF and the "Send to my CA"
  Excel are shown as messages only; no file is generated.
- **No real upload or compression** — the upload progress and the "made small"
  figures are a demonstration.
- **Simulated video** — the video area shows a moving progress bar, not a real
  video.
- **Scripted activity** — the "Who watched" feed uses sample activity, not real
  link analytics.
- **Placeholder details** — machine artwork, photos, prices, the sample GSTIN and
  the catalogue are placeholders for the demo.

The actual application will be developed according to the client's exact
requirements, database, permissions, integrations, business rules and deployment
requirements.

---

## 10. Future Production Application

During real development, the following can be added (these do **not** exist in
the prototype yet):

- **Secure login** with real mobile-number / OTP or password authentication.
- **User roles and permissions** so owner, sales, admin and accounts see only
  what they should.
- **A real database** so every machine, customer, enquiry, quotation and money
  entry is stored.
- **Data persistence** so nothing is lost on refresh or when switching devices.
- **Cloud storage** for real machine videos, photos and catalog PDFs.
- **Real quotation and invoice generation** as downloadable PDFs.
- **WhatsApp integration** to actually send machines and quotations.
- **Payment tracking** for advances, balances and dues.
- **Advanced reports** and exports for accounts and the CA.
- **Backup** of all business data.
- **Security** measures appropriate for business data.
- **Audit logs** of who did what and when.
- **Production deployment** on a proper domain with monitoring.

---

## 11. Client Requirement Confirmation

Before final development begins, the following should be confirmed with Chawla
Industries so the built application matches the business exactly:

- **Exact modules** required (and any not needed).
- **User roles** and who is allowed to do what.
- **Machine / product information** — the fields, specifications and media for
  each machine.
- **Quotation format** — layout, terms, numbering and branding.
- **GST requirements** — applicable rates, HSN codes and the correct GSTIN.
- **Billing requirements** — invoice format and numbering.
- **Payment process** — advance percentage, balance terms and how payments are
  recorded.
- **Reports** — which reports and figures management needs.
- **WhatsApp requirements** — what should be sent, and from which number.
- **Language requirements** — English, Gujarati or both, and where.
- **Hosting / domain** — the web address and hosting preference.
- **Database** — what data must be stored and for how long.
- **Backup** — how often and where.
- **Other integrations** — accounting software, the CA's format, or any other
  tools.

---

### Prototype Contents (for reference)

The prototype is delivered as a single self-contained web page:

- `index.html` — the complete prototype (all screens, logic and sample data).
- `wrangler.toml` — configuration for hosting the demo on Cloudflare.
- `DEPLOY.md` — step-by-step deployment notes for the demo link.

Opening `index.html` on a phone gives the most realistic feel of the final app.

---

*Prepared by Sangam InfoAnalytics for Chawla Industries. This document describes
the prototype only and is intended for client presentation and internal
development understanding. Final scope and features will be confirmed with the
client before production development.*
