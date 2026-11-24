<!DOCTYPE html>
<html lang="bn" dir="ltr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Rs online — কাস্টমার পোর্টাল</title>
  <style>
    :root {
      --bg-dark: #070b14;
      --glass-bg: rgba(17, 25, 46, 0.72);
      --glass-border: rgba(148, 163, 184, 0.22);
      --text-main: #f1f5f9;
      --text-muted: #94a3b8;
      --accent-cyan: #22d3ee;
      --accent-blue: #3b82f6;
      --bkash: #e2136e;
      --nagad: #f6921e;
      --success: #10b981;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      text-align: left;
    }

    body {
      font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Noto Sans Bengali", sans-serif;
      background-color: var(--bg-dark);
      color: var(--text-main);
      min-height: 100vh;
      line-height: 1.55;
      position: relative;
      overflow-x: hidden;
    }

    /* 3D Optical Fiber Background Effect */
    .fiber-bg {
      position: fixed;
      inset: 0;
      z-index: -1;
      overflow: hidden;
      background: radial-gradient(circle at 15% 15%, rgba(34, 211, 238, 0.14), transparent 45%),
                  radial-gradient(circle at 85% 25%, rgba(59, 130, 246, 0.16), transparent 50%),
                  linear-gradient(160deg, #050811 0%, #0b1326 55%, #060a14 100%);
    }

    .fiber-strand {
      position: absolute;
      width: 140%;
      height: 2px;
      left: -20%;
      background: linear-gradient(90deg, transparent, rgba(34, 211, 238, 0.65), rgba(59, 130, 246, 0.85), transparent);
      box-shadow: 0 0 14px rgba(34, 211, 238, 0.55);
      transform-origin: center;
      animation: fiberFlow 9s linear infinite;
      opacity: 0.45;
    }

    .fiber-strand:nth-child(1) { top: 14%; transform: rotate(-12deg); animation-duration: 8s; }
    .fiber-strand:nth-child(2) { top: 32%; transform: rotate(-8deg); animation-duration: 11s; animation-delay: -2s; }
    .fiber-strand:nth-child(3) { top: 52%; transform: rotate(-15deg); animation-duration: 9.5s; animation-delay: -4s; }
    .fiber-strand:nth-child(4) { top: 71%; transform: rotate(-7deg); animation-duration: 12s; animation-delay: -6s; }
    .fiber-strand:nth-child(5) { top: 88%; transform: rotate(-11deg); animation-duration: 10s; animation-delay: -3s; }

    @keyframes fiberFlow {
      0% { transform: translateX(-18%) rotate(-10deg) scaleY(1); }
      50% { transform: translateX(18%) rotate(-10deg) scaleY(1.6); }
      100% { transform: translateX(-18%) rotate(-10deg) scaleY(1); }
    }

    .container {
      max-width: 1240px;
      margin: 0 auto;
      padding: 20px 18px 40px;
    }

    .glass {
      background: var(--glass-bg);
      backdrop-filter: blur(14px);
      -webkit-backdrop-filter: blur(14px);
      border: 1px solid var(--glass-border);
      border-radius: 16px;
      box-shadow: 0 12px 32px rgba(0, 0, 0, 0.35);
    }

    header.glass {
      padding: 18px 22px;
      margin-bottom: 22px;
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      align-items: center;
      gap: 14px;
    }

    .brand-title {
      font-size: 1.55rem;
      font-weight: 800;
      color: var(--accent-cyan);
      letter-spacing: 0.3px;
    }

    .brand-sub {
      color: var(--text-muted);
      font-size: 0.92rem;
      margin-top: 2px;
    }

    .hotlines {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }

    .hotline-badge {
      background: rgba(15, 23, 42, 0.85);
      border: 1px solid rgba(34, 211, 238, 0.35);
      padding: 8px 14px;
      border-radius: 10px;
      font-size: 0.9rem;
      color: #e2e8f0;
    }

    .main-grid {
      display: grid;
      grid-template-columns: 1.45fr 1fr;
      gap: 22px;
      align-items: start;
    }

    @media (max-width: 900px) {
      .main-grid {
        grid-template-columns: 1fr;
      }
    }

    .section-card {
      padding: 20px;
    }

    .section-title {
      font-size: 1.2rem;
      font-weight: 700;
      margin-bottom: 14px;
      color: #f8fafc;
    }

    .packages-grid {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 14px;
    }

    @media (max-width: 560px) {
      .packages-grid {
        grid-template-columns: 1fr;
      }
    }

    .pkg-card {
      background: rgba(15, 23, 42, 0.72);
      border: 1px solid rgba(148, 163, 184, 0.22);
      border-radius: 14px;
      padding: 16px;
      transition: transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
    }

    .pkg-card.active {
      border-color: var(--accent-cyan);
      box-shadow: 0 0 0 1px var(--accent-cyan), 0 10px 24px rgba(34, 211, 238, 0.16);
    }

    .pkg-speed {
      font-size: 1.25rem;
      font-weight: 800;
      color: var(--accent-cyan);
    }

    .pkg-price {
      font-size: 1.05rem;
      font-weight: 700;
      color: #f8fafc;
      margin: 4px 0 8px;
    }

    .pkg-desc {
      font-size: 0.88rem;
      color: var(--text-muted);
      margin-bottom: 14px;
    }

    .pkg-actions {
      display: flex;
      gap: 10px;
    }

    .btn {
      border: none;
      border-radius: 10px;
      padding: 9px 14px;
      font-size: 0.9rem;
      font-weight: 700;
      cursor: pointer;
      color: #ffffff;
      transition: opacity 0.2s ease, transform 0.15s ease;
    }

    .btn:hover {
      opacity: 0.92;
      transform: translateY(-1px);
    }

    .btn-bkash {
      background-color: var(--bkash);
      flex: 1;
    }

    .btn-nagad {
      background-color: var(--nagad);
      flex: 1;
    }

    .btn-primary {
      background: linear-gradient(135deg, var(--accent-blue), var(--accent-cyan));
      color: #04101d;
      width: 100%;
    }

    .right-column {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    .summary-box {
      background: rgba(15, 23, 42, 0.82);
      border: 1px solid rgba(148, 163, 184, 0.2);
      border-radius: 12px;
      padding: 14px;
      margin-bottom: 14px;
      font-size: 0.92rem;
    }

    .summary-row {
      margin-bottom: 6px;
      color: #e2e8f0;
    }

    .summary-row:last-child {
      margin-bottom: 0;
    }

    .method-switch {
      display: flex;
      gap: 10px;
      margin-bottom: 14px;
    }

    .method-pill {
      flex: 1;
      padding: 9px 12px;
      border-radius: 10px;
      border: 1px solid rgba(148, 163, 184, 0.25);
      background: rgba(15, 23, 42, 0.7);
      color: #cbd5e1;
      font-weight: 700;
      font-size: 0.9rem;
      cursor: pointer;
    }

    .method-pill.selected-bkash {
      background: rgba(226, 19, 110, 0.22);
      border-color: var(--bkash);
      color: #fff;
    }

    .method-pill.selected-nagad {
      background: rgba(246, 146, 30, 0.22);
      border-color: var(--nagad);
      color: #fff;
    }

    .form-group {
      margin-bottom: 12px;
    }

    .form-label {
      display: block;
      font-size: 0.88rem;
      color: #cbd5e1;
      margin-bottom: 6px;
    }

    .form-input, .form-textarea {
      width: 100%;
      padding: 10px 12px;
      border-radius: 10px;
      border: 1px solid rgba(148, 163, 184, 0.28);
      background: rgba(9, 14, 28, 0.88);
      color: #f8fafc;
      font-size: 0.92rem;
      font-family: inherit;
    }

    .form-input:focus, .form-textarea:focus {
      outline: none;
      border-color: var(--accent-cyan);
    }

    .status-msg {
      margin-top: 10px;
      padding: 10px 12px;
      border-radius: 10px;
      font-size: 0.88rem;
      display: none;
    }

    .status-msg.show {
      display: block;
      background: rgba(16, 185, 129, 0.16);
      border: 1px solid rgba(16, 185, 129, 0.45);
      color: #a7f3d0;
    }

    .chat-thread {
      max-height: 290px;
      overflow-y: auto;
      display: flex;
      flex-direction: column;
      gap: 10px;
      margin-bottom: 14px;
      padding-right: 4px;
    }

    .msg-bubble {
      padding: 10px 13px;
      border-radius: 12px;
      font-size: 0.9rem;
      max-width: 92%;
    }

    .msg-user {
      align-self: flex-start;
      background: rgba(59, 130, 246, 0.22);
      border: 1px solid rgba(59, 130, 246, 0.45);
      color: #f1f5f9;
    }

    .msg-bot {
      align-self: flex-start;
      background: rgba(15, 23, 42, 0.9);
      border: 1px solid rgba(34, 211, 238, 0.35);
      color: #e2e8f0;
    }

    .msg-sender {
      font-size: 0.78rem;
      font-weight: 700;
      color: var(--accent-cyan);
      margin-bottom: 3px;
    }

    footer.glass {
      margin-top: 24px;
      padding: 16px 22px;
      font-size: 0.88rem;
      color: var(--text-muted);
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      gap: 10px;
    }
  </style>
</head>
<body>
  <div class="fiber-bg" aria-hidden="true">
    <div class="fiber-strand"></div>
    <div class="fiber-strand"></div>
    <div class="fiber-strand"></div>
    <div class="fiber-strand"></div>
    <div class="fiber-strand"></div>
  </div>

  <div class="container">
    <header class="glass">
      <div>
        <div class="brand-title">Rs online</div>
        <div class="brand-sub">দ্রুত ও নির্ভরযোগ্য অপটিক্যাল ফাইবার ইন্টারনেট কাস্টমার পোর্টাল</div>
      </div>
      <div class="hotlines">
        <div class="hotline-badge">হটলাইন ১: 09697203499</div>
        <div class="hotline-badge">হটলাইন ২: 09658670149</div>
      </div>
    </header>

    <div class="main-grid">
      <section class="glass section-card">
        <h2 class="section-title">ইন্টারনেট প্যাকেজসমূহ</h2>
        <div class="packages-grid" id="packagesContainer"></div>
      </section>

      <div class="right-column">
        <section class="glass section-card" id="paymentSection">
          <h2 class="section-title">পেমেন্ট বক্স</h2>

          <div class="summary-box">
            <div class="summary-row">সিলেক্টেড প্যাকেজ: <strong id="selectedPkgText">২০ Mbps — ৬০০ টাকা</strong></div>
            <div class="summary-row">পরিশোধযোগ্য অ্যামাউন্ট: <strong id="selectedAmountText">৬০০ টাকা</strong></div>
            <div class="summary-row">পেমেন্ট নম্বর: <strong id="paymentNumberText">01759887499 (বিকাশ / WhatsApp)</strong></div>
          </div>

          <div class="method-switch">
            <button type="button" class="method-pill selected-bkash" id="pillBkash" onclick="setPaymentMethod('bKash')">বিকাশ</button>
            <button type="button" class="method-pill" id="pillNagad" onclick="setPaymentMethod('Nagad')">নগদ</button>
          </div>

          <form id="paymentForm" onsubmit="handlePaymentSubmit(event)">
            <div class="form-group">
              <label class="form-label" for="payerPhone">আপনার মোবাইল নম্বর</label>
              <input type="text" id="payerPhone" class="form-input" placeholder="যেমন: 017xxxxxxxx" required />
            </div>
            <div class="form-group">
              <label class="form-label" for="trxId">ট্রানজেকশন আইডি (TrxID)</label>
              <input type="text" id="trxId" class="form-input" placeholder="পেমেন্টের TrxID লিখুন" required />
            </div>
            <button type="submit" class="btn btn-primary">পেমেন্ট কনফার্ম করুন</button>
          </form>

          <div class="status-msg" id="paymentStatus"></div>
        </section>

        <section class="glass section-card" id="supportSection">
          <h2 class="section-title">অভিযোগ ও সাপোর্ট বক্স</h2>

          <div class="chat-thread" id="chatThread">
            <div class="msg-bubble msg-bot">
              <div class="msg-sender">Rs online সাপোর্ট</div>
              <div>আসসালামু আলাইকুম! আপনার যেকোনো অভিযোগ, বিল, স্পিড বা সংযোগ সংক্রান্ত প্রশ্ন এখানে লিখুন।</div>
            </div>
          </div>

          <form id="supportForm" onsubmit="handleSupportSubmit(event)">
            <div class="form-group">
              <textarea id="complaintInput" rows="2" class="form-textarea" placeholder="আপনার সমস্যা বা মেসেজ লিখুন..." required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">মেসেজ পাঠান</button>
          </form>
        </section>
      </div>
    </div>

    <footer class="glass">
      <div>Rs online — গ্রাহক সেবা কেন্দ্র</div>
      <div>হটলাইন: 09697203499 | 09658670149</div>
    </footer>
  </div>

  <script>
    const packages = [
      { id: 1, name: "২০ Mbps", price: 600, priceBn: "৬০০ টাকা", desc: "সাধারণ ব্রাউজিং, সোশ্যাল মিডিয়া ও নিয়মিত অনলাইন কাজের জন্য উপযোগী।" },
      { id: 2, name: "৩০ Mbps", price: 700, priceBn: "৭০০ টাকা", desc: "HD ভিডিও স্ট্রিমিং, অনলাইন ক্লাস ও স্মার্ট টিভির জন্য দারুণ প্যাকেজ।" },
      { id: 3, name: "৪০ Mbps", price: 800, priceBn: "৮০০ টাকা", desc: "পরিবারের একাধিক ডিভাইস ও নিরবচ্ছিন্ন কাজের জন্য আদর্শ গতি।" },
      { id: 4, name: "৫০ Mbps", price: 900, priceBn: "৯০০ টাকা", desc: "ফাস্ট ডাউনলোড, রিমোট ওয়ার্ক ও স্মুথ স্ট্রিমিংয়ের জন্য শক্তিশালী প্যাকেজ।" },
      { id: 5, name: "৬০ Mbps", price: 1000, priceBn: "১,০০০ টাকা", desc: "হেভি ইউজার ও মাল্টি-ডিভাইস হোম নেটওয়ার্কের জন্য উচ্চগতির সংযোগ।" },
      { id: 6, name: "৭০ Mbps", price: 1100, priceBn: "১,১০০ টাকা", desc: "লো-ল্যাটেন্সি গেমিং ও বড় ফাইল আদান-প্রদানের জন্য নির্ভরযোগ্য স্পিড।" },
      { id: 7, name: "১০০ Mbps", price: 1250, priceBn: "১,২৫০ টাকা", desc: "আল্ট্রা-ফাস্ট ফাইবার স্পিড—সব ধরনের হেভি কাজের জন্য সেরা সমাধান।" }
    ];

    const paymentNumbers = {
      bKash: "01759887499 (বিকাশ / WhatsApp)",
      Nagad: "01869466643 (নগদ)"
    };

    let selectedPkg = packages[0];
    let selectedMethod = "bKash";

    function renderPackages() {
      const container = document.getElementById("packagesContainer");
      container.innerHTML = packages.map(pkg => {
        const isActive = pkg.id === selectedPkg.id ? "active" : "";
        return `
          <div class="pkg-card ${isActive}" id="pkg-card-${pkg.id}">
            <div class="pkg-speed">${pkg.name}</div>
            <div class="pkg-price">${pkg.priceBn} / মাস</div>
            <div class="pkg-desc">${pkg.desc}</div>
            <div class="pkg-actions">
              <button type="button" class="btn btn-bkash" onclick="selectPkgAndMethod(${pkg.id}, 'bKash')">বিকাশ</button>
              <button type="button" class="btn btn-nagad" onclick="selectPkgAndMethod(${pkg.id}, 'Nagad')">নগদ</button>
            </div>
          </div>
        `;
      }).join("");
    }

    function updatePaymentUI() {
      document.querySelectorAll(".pkg-card").forEach(card => card.classList.remove("active"));
      const activeCard = document.getElementById(`pkg-card-${selectedPkg.id}`);
      if (activeCard) activeCard.classList.add("active");

      document.getElementById("selectedPkgText").textContent = `${selectedPkg.name} — ${selectedPkg.priceBn}`;
      document.getElementById("selectedAmountText").textContent = `${selectedPkg.priceBn}`;
      document.getElementById("paymentNumberText").textContent = paymentNumbers[selectedMethod];

      const pillBkash = document.getElementById("pillBkash");
      const pillNagad = document.getElementById("pillNagad");
      pillBkash.className = "method-pill" + (selectedMethod === "bKash" ? " selected-bkash" : "");
      pillNagad.className = "method-pill" + (selectedMethod === "Nagad" ? " selected-nagad" : "");
    }

    function selectPkgAndMethod(pkgId, method) {
      const found = packages.find(p => p.id === pkgId);
      if (found) selectedPkg = found;
      selectedMethod = method;
      updatePaymentUI();
      document.getElementById("paymentSection").scrollIntoView({ behavior: "smooth", block: "nearest" });
    }

    function setPaymentMethod(method) {
      selectedMethod = method;
      updatePaymentUI();
    }

    function handlePaymentSubmit(event) {
      event.preventDefault();
      const phone = document.getElementById("payerPhone").value.trim();
      const trx = document.getElementById("trxId").value.trim();
      const statusBox = document.getElementById("paymentStatus");

      statusBox.textContent = `ধন্যবাদ! ${selectedPkg.name} (${selectedPkg.priceBn}) প্যাকেজের জন্য ${selectedMethod} পেমেন্ট তথ্য (নম্বর: ${phone}, TrxID: ${trx}) গ্রহণ করা হয়েছে।`;
      statusBox.classList.add("show");
      event.target.reset();
    }

    function getAutoReply(text) {
      const q = text.toLowerCase();

      if (q.includes("সালাম") || q.includes("আসসালাম") || q.includes("হ্যালো") || q.includes("hi") || q.includes("hello")) {
        return "ওয়ালাইকুম আসসালাম! Rs online সাপোর্টে আপনাকে স্বাগতম। আপনার সমস্যা বা প্রয়োজনটি বিস্তারিত লিখুন।";
      }
      if (q.includes("স্পিড") || q.includes("স্লো") || q.includes("slow") || q.includes("speed") || q.includes("ping") || q.includes("বাপার")) {
        return "স্পিড কম মনে হলে রাউটার ও ONU/মিডিয়া কনভার্টারটি ১ মিনিট বন্ধ রেখে পুনরায় চালু করুন। সমস্যা থাকলে হটলাইন 09697203499 বা 09658670149 নম্বরে যোগাযোগ করুন।";
      }
      if (q.includes("নেট") || q.includes("লাইন") || q.includes("ডিসকানেক্ট") || q.includes("লাল") || q.includes("los") || q.includes("pon") || q.includes("ইন্টারনেট")) {
        return "লাইন বা সংযোগ বিচ্ছিন্ন হয়ে থাকলে ফাইবার ক্যাবল ও রাউটারের পাওয়ার লাইট চেক করুন। দ্রুত লাইন চেক করতে 09697203499 অথবা 09658670149 নম্বরে কল করুন।";
      }
      if (q.includes("বিল") || q.includes("টাকা") || q.includes("বিকাশ") || q.includes("নগদ") || q.includes("পেমেন্ট") || q.includes("bkash") || q.includes("nagad")) {
        return "পেমেন্টের জন্য বিকাশ/WhatsApp: 01759887499 এবং নগদ: 01869466643 ব্যবহার করতে পারেন। পেমেন্ট বক্সে TrxID সাবমিট করলে দ্রুত যাচাই করা হবে।";
      }
      if (q.includes("নতুন") || q.includes("সংযোগ") || q.includes("কানেকশন") || q.includes("প্যাকেজ")) {
        return "নতুন সংযোগ বা প্যাকেজ পরিবর্তনের জন্য পছন্দের প্যাকেজ সিলেক্ট করুন অথবা 09697203499 / 09658670149 নম্বরে যোগাযোগ করুন।";
      }
      if (q.includes("পাসওয়ার্ড") || q.includes("ওয়াইফাই") || q.includes("wifi") || q.includes("password") || q.includes("রাউটার")) {
        return "ওয়াইফাই নাম বা পাসওয়ার্ড পরিবর্তনের প্রয়োজন হলে আপনার ইউজার/নম্বর ও কাঙ্ক্ষিত তথ্যসহ 09697203499 অথবা 09658670149 নম্বরে যোগাযোগ করুন।";
      }
      return "আপনার মেসেজটি আমরা পেয়েছি। জরুরি সহায়তার জন্য সরাসরি 09697203499 অথবা 09658670149 হটলাইনে কল করতে পারেন।";
    }

    function appendMessage(sender, text, type) {
      const thread = document.getElementById("chatThread");
      const bubble = document.createElement("div");
      bubble.className = `msg-bubble ${type === "user" ? "msg-user" : "msg-bot"}`;

      const senderEl = document.createElement("div");
      senderEl.className = "msg-sender";
      senderEl.textContent = sender;

      const textEl = document.createElement("div");
      textEl.textContent = text;

      bubble.appendChild(senderEl);
      bubble.appendChild(textEl);
      thread.appendChild(bubble);
      thread.scrollTop = thread.scrollHeight;
    }

    function handleSupportSubmit(event) {
      event.preventDefault();
      const input = document.getElementById("complaintInput");
      const message = input.value.trim();
      if (!message) return;

      appendMessage("আপনি", message, "user");
      const reply = getAutoReply(message);
      appendMessage("Rs online সাপোর্ট", reply, "bot");
      input.value = "";
    }

    renderPackages();
    updatePaymentUI();
  </script>
</body>
</html>
