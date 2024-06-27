import csv
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# SMTP Server Configuration
smtp_username = 'xxx@xxxx'
smtp_password = 'xxxxx'
smtp_server = 'mail.ncse.tw'
smtp_port = 587

# CSV Data
csv_data = """AC0180,毛哥EM,info@elvismao.com,
AC0181,Elvis Mao,elvismao@mail.edu.tw,"""

# Email Template
html_template = """\
<html>
    <body style="padding: 0; margin: 0">
        <div style="background-color: #eeeeee; padding: 4rem 2rem">
            <div
                style="
                    background-color: #fff;
                    padding: 1rem;
                    max-width: 600px;
                    margin: auto;
                    border-radius: 2rem;
                "
            >
                <img
                    src="https://apcs-simulation.com/static/logo.png"
                    width="100px"
                    style="
                        display: block;
                        margin: auto;
                        border-radius: 50%;
                        position: relative;
                        transform: translateY(-50px);
                    "
                />
                <p>
                    {{name}} 您好，<br />
                    　　恭喜您獲選為本次【APCS 模擬測驗團隊 x APCS Guide
                    聯合暑期營隊】之<span style="color: green; font-weight: 900"
                        >正取學員</span
                    >，本封信件為錄取暨繳費通知信，請務必詳細閱讀並於時限內繳費才算為完成報名程序。
                </p>

                <h2>活動資訊</h2>
                <ul>
                    <li>
                        <b>營隊日期：</b><br />2024 / 08 / 12（一）～2024 / 08
                        / 24（六），不含星期日，共計 12 天。
                    </li>
                    <li>
                        <b>主辦單位：</b>
                        <br />APCS 模擬測驗團隊<br />
                        APCS Guide 程式教育創新計劃執行團隊
                    </li>
                </ul>

                <h2>繳費資訊</h2>
                <ul>
                    <li>帳務編號：{{inv_id}}</li>
                    <li>
                        繳款方式：銀行轉帳，如無法銀行轉帳者，請與我們聯繫。
                    </li>
                    <li>
                        <span style="color: red; font-weight: 600"
                            >轉帳時，請於備註欄填寫帳務編號，以便我們對帳。</span
                        >
                    </li>
                    <li>繳費期限：6/24 （一）23:59（逾期視同放棄）</li>
                    <li>應繳金額：NT. 1200</li>
                    <li>中華郵政（代號 700）</li>
                    <li>帳號：03011780999281</li>
                    <li>戶名：鍾秉均</li>
                </ul>
                <p>
                    繳費完成後，<span style="color: red; font-weight: 600"
                        >請填寫繳費確認表單。</span
                    ><br />
                    表單連結：<a href="https://forms.gle/D3R9hxNMcHS5agqF8"
                        >https://forms.gle/D3R9hxNMcHS5agqF8</a
                    >
                </p>
                <h2>繳費狀態查詢</h2>
                <p>
                    若您想查詢繳費狀態與處理進度，可以使用我們製作的「繳費狀態查詢網站」（<a
                        href="https://camp.apcs-simulation.com"
                        >camp.apcs-simulation.com</a
                    >），輸入學員姓名後即可查詢帳務編號、表單等相關資訊！
                </p>
                <p>
                    如有任何活動相關問題，請直接回信或透過我們的 Instagram
                    詢問。<br />
                    以上，祝各位在營隊期間滿載而歸！<br /><br />
                    Best Regards,<br />
                    APCS 模擬測驗團隊 x APCS Guide 聯合暑期營隊
                </p>
                <p style="font-size: 0.8rem">
                    電子郵件：<a href="mailto:apcscamp2024@gmail.com"
                        >apcscamp2024@gmail.com</a
                    ><br />
                    Instagram：<a href="https://www.instagram.com/apcs.guide/"
                        >https://www.instagram.com/apcs.guide/</a
                    ><br />
                    Instagram：<a
                        href="https://www.instagram.com/apcs.simulation/"
                        >https://www.instagram.com/apcs.simulation/</a
                    ><br />
                </p>
            </div>
        </div>
    </body>
</html>

"""

# Read the CSV data
reader = csv.reader(csv_data.splitlines())

# SMTP server setup
server = smtplib.SMTP(smtp_server, smtp_port)
server.starttls()
server.login(smtp_username, smtp_password)

for row in reader:
    if len(row) >= 3:
        name, email = row[1], row[2]
        # Replace placeholders in the template
        html_content = html_template.replace('{{name}}', name).replace('{{inv_id}}', row[0])
        # Create email message
        message = MIMEMultipart()
        message['From'] = "camp@apcs-simulation.com"  # Display name and email
        message['To'] = email  # To the primary recipient
        message['CC'] = "yuan@ncse.tw, apcscamp2024@gmail.com" 
        message['Bcc'] = "yuan@ncse.tw, apcscamp2024@gmail.com"  # BCC other recipients
        message['Subject'] = 'APCS 模擬測驗團隊 x APCS Guide 聯合暑期營隊錄取通知'
        message['Reply-To'] = "apcscamp2024@gmail.com"  # Reply-To address
        message.attach(MIMEText(html_content, 'html'))
        # Send the email
        server.sendmail(smtp_username, email, message.as_string())
        print(f"Email sent to {name} at {email}")
server.quit()
print("All emails sent successfully!")
