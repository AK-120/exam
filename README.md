# please removes first line of java code 
example 
```java
package com.example.calculator;
```
###### Good Luck
---
***
># Basic Calculator
>>```activity_main.xml```
``` xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:padding="16dp"
    android:orientation="vertical">

    <EditText
        android:id="@+id/number1"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Enter first number"
        android:inputType="numberDecimal"/>

    <EditText
        android:id="@+id/number2"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Enter second number"
        android:inputType="numberDecimal"/>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="center"
        android:layout_marginTop="16dp">

        <Button android:id="@+id/add"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="+" />

        <Button android:id="@+id/subtract"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="-" />

        <Button android:id="@+id/multiply"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="×" />

        <Button android:id="@+id/divide"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="÷" />
    </LinearLayout>

    <TextView
        android:id="@+id/result"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Result will appear here"
        android:textSize="18sp"
        android:layout_marginTop="20dp"/>
</LinearLayout>
 ```
>>``MainActivity.java``
```java
package com.example.calculator;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.*;

public class MainActivity extends AppCompatActivity {

    EditText number1, number2;
    TextView result;
    Button add, subtract, multiply, divide;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        number1 = findViewById(R.id.number1);
        number2 = findViewById(R.id.number2);
        result = findViewById(R.id.result);

        add = findViewById(R.id.add);
        subtract = findViewById(R.id.subtract);
        multiply = findViewById(R.id.multiply);
        divide = findViewById(R.id.divide);

        add.setOnClickListener(view -> calculate('+'));
        subtract.setOnClickListener(view -> calculate('-'));
        multiply.setOnClickListener(view -> calculate('*'));
        divide.setOnClickListener(view -> calculate('/'));
    }

    private void calculate(char operator) {
        String input1 = number1.getText().toString();
        String input2 = number2.getText().toString();

        if (input1.isEmpty() || input2.isEmpty()) {
            result.setText("Please enter both numbers.");
            return;
        }

        double num1 = Double.parseDouble(input1);
        double num2 = Double.parseDouble(input2);
        double res = 0;

        switch (operator) {
            case '+': res = num1 + num2; break;
            case '-': res = num1 - num2; break;
            case '*': res = num1 * num2; break;
            case '/':
                if (num2 == 0) {
                    result.setText("Cannot divide by zero!");
                    return;
                }
                res = num1 / num2;
                break;
        }

        result.setText("Result: " + res);
    }
}
```
---
># Login form using intent
>>## activity_main.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp"
    android:gravity="center">

    <EditText
        android:id="@+id/username"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Username"
        android:inputType="textPersonName" />

    <EditText
        android:id="@+id/password"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Password"
        android:inputType="textPassword"
        android:layout_marginTop="12dp"/>

    <Button
        android:id="@+id/loginBtn"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Login"
        android:layout_marginTop="20dp"/>
</LinearLayout>
```
>>``MainActivity.java``
```java
package com.example.loginapp;

import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.*;

public class MainActivity extends AppCompatActivity {

    EditText username, password;
    Button loginBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        username = findViewById(R.id.username);
        password = findViewById(R.id.password);
        loginBtn = findViewById(R.id.loginBtn);

        loginBtn.setOnClickListener(v -> {
            String user = username.getText().toString();
            String pass = password.getText().toString();

            if (user.equals("admin") && pass.equals("1234")) {
                Intent intent = new Intent(MainActivity.this, WelcomeActivity.class);
                intent.putExtra("username", user); // passing username
                startActivity(intent);
            } else {
                Toast.makeText(MainActivity.this, "Invalid credentials", Toast.LENGTH_SHORT).show();
            }
        });
    }
}
```
>>``activity_welcome.xml``
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:gravity="center"
    android:orientation="vertical"
    android:padding="24dp">

    <TextView
        android:id="@+id/welcomeText"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:textSize="24sp"/>
</LinearLayout>
```
>>``WelcomeActivity.java``
```java
package com.example.loginapp;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class WelcomeActivity extends AppCompatActivity {

    TextView welcomeText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome);

        welcomeText = findViewById(R.id.welcomeText);

        String username = getIntent().getStringExtra("username");
        welcomeText.setText("Welcome, " + username + "!");
    }
}
```
>>``AndroidManifest.xml (Declare both activities) only and these line in application tag ``
```xml
<activity android:name=".WelcomeActivity" />
    <activity android:name=".MainActivity">
        <intent-filter>
            <action android:name="android.intent.action.MAIN" />
            <category android:name="android.intent.category.LAUNCHER" />
        </intent-filter>
    </activity>
```
---
># Login form using toast
>> ``activity_main.xml``
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp"
    android:gravity="center">

    <EditText
        android:id="@+id/username"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Username"
        android:inputType="textPersonName" />

    <EditText
        android:id="@+id/password"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Password"
        android:inputType="textPassword"
        android:layout_marginTop="12dp"/>

    <Button
        android:id="@+id/loginBtn"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Login"
        android:layout_marginTop="20dp"/>
</LinearLayout>
```
>>``MainActivity.java``
```java
package com.example.loginform;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.*;

public class MainActivity extends AppCompatActivity {

    EditText username, password;
    Button loginBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        username = findViewById(R.id.username);
        password = findViewById(R.id.password);
        loginBtn = findViewById(R.id.loginBtn);

        loginBtn.setOnClickListener(v -> {
            String user = username.getText().toString().trim();
            String pass = password.getText().toString().trim();

            if (user.equals("admin") && pass.equals("1234")) {
                Toast.makeText(MainActivity.this, "Login Successful!", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(MainActivity.this, "Invalid Credentials", Toast.LENGTH_SHORT).show();
            }
        });
    }
}
```
---
># Digital clock
>>``activity_main.xml``
```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout 
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:gravity="center">

    <TextView
        android:id="@+id/digitalClock"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="00:00:00"
        android:textSize="48sp"
        android:textStyle="bold"
        android:layout_centerInParent="true"
        android:textColor="#000000"/>
</RelativeLayout>
```
>>``MainActivity.java``
```java
package com.example.digitalclock;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.os.Handler;
import android.widget.TextView;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    TextView digitalClock;
    Handler handler = new Handler();
    Runnable runnable;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        digitalClock = findViewById(R.id.digitalClock);

        runnable = new Runnable() {
            @Override
            public void run() {
                String currentTime = new SimpleDateFormat("HH:mm:ss", Locale.getDefault()).format(new Date());
                digitalClock.setText(currentTime);
                handler.postDelayed(this, 1000); // update every 1 second
            }
        };

        handler.post(runnable);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        handler.removeCallbacks(runnable); // stop handler when activity is destroyed
    }
}
```
---
># analog clock
>>``activity_main.xml``
```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout 
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:gravity="center">

    <AnalogClock
        android:id="@+id/analogClock"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_centerInParent="true" />
</RelativeLayout>
```
>>``MainActivity.java``
```java
package com.example.analogclock;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
```
---
># Digital and Analog Clock
>>``activity_main.xml``
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout 
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="16dp">

    <AnalogClock
        android:id="@+id/analogClock"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginBottom="32dp"/>

    <TextView
        android:id="@+id/digitalClock"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="00:00:00"
        android:textSize="36sp"
        android:textStyle="bold"
        android:textColor="#000000"/>
</LinearLayout>
```
>>``MainActivity.java``
```java
package com.example.clockapp;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.os.Handler;
import android.widget.TextView;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    TextView digitalClock;
    Handler handler = new Handler();
    Runnable updateClock;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        digitalClock = findViewById(R.id.digitalClock);

        updateClock = new Runnable() {
            @Override
            public void run() {
                String currentTime = new SimpleDateFormat("HH:mm:ss", Locale.getDefault()).format(new Date());
                digitalClock.setText(currentTime);
                handler.postDelayed(this, 1000);
            }
        };

        handler.post(updateClock);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        handler.removeCallbacks(updateClock); // Clean up handler
    }
}
```
