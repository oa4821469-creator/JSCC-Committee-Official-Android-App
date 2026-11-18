# JSCC লাইভ আপডেট (Real-time Sync) — বাস্তবায়ন নোট

## কাঙ্ক্ষিত আচরণ
- সুপার অ্যাডমিনের ফোনে অনুমোদিত সদস্য/কমিটি/হিসাব পরিবর্তন হলে ক্লাউড ডেটাবেজে সংরক্ষিত হবে।
- অন্য সদস্যদের অ্যাপে খোলা অবস্থায় Supabase Realtime event এলে অ্যাপ নতুন তথ্য আবার সার্ভার থেকে পড়বে।
- অ্যাপ বন্ধ থাকলে Firebase Cloud Messaging (FCM) দিয়ে সাধারণ নোটিফিকেশন পাঠানো হবে।
- পুশ নোটিফিকেশনে ব্যক্তিগত সদস্যতথ্য, ব্যাংক ব্যালেন্স বা লেনদেনের গোপন বিবরণ পাঠানো হবে না; শুধু “নতুন অনুমোদিত আপডেট আছে” ধরনের বার্তা থাকবে।

## এই সোর্সে যা যোগ হয়েছে
- `supabase_flutter` dependency যোগ করা হয়েছে।
- `lib/services/jscc_realtime_service.dart`-এ profiles, ledger_entries, committee_members ও notifications টেবিলের database change listener-এর প্রাথমিক helper যোগ করা হয়েছে।

## এখনো সংযোগ/সেটআপ বাকি
1. Supabase project তৈরি করে Project URL ও anon/publishable key নিরাপদভাবে app configuration-এ যোগ করতে হবে। Service-role key কখনো অ্যাপে রাখা যাবে না।
2. Supabase-এ সব সংবেদনশীল টেবিলে RLS policy এবং role-based access সম্পূর্ণ করতে হবে।
3. `notifications` কেবল অনুমোদিত পরিবর্তনের পর publish হবে—এটি server-side transaction/function দিয়ে নিশ্চিত করতে হবে।
4. Realtime publication-এ প্রয়োজনীয় টেবিল চালু করতে হবে।
5. FCM Android configuration ও server-side notification sender যোগ করতে হবে।
6. Flutter app-এর screen-গুলোকে realtime service-এর event অনুযায়ী fresh database query দিয়ে refresh করতে হবে।
7. দুইটি test phone/account দিয়ে member edit, ledger approval, denied access এবং offline/online পুনঃসংযোগ পরীক্ষা করতে হবে।

## নিরাপত্তা
- UI-তে বাটন লুকানোই নিরাপত্তা নয়; প্রতিটি read/write সার্ভার-side policy দিয়ে যাচাই করতে হবে।
- pending পরিবর্তন সাধারণ সদস্যদের query-তে আসবে না।
- আর্থিক এন্ট্রি edit/delete না করে correction/reversal entry এবং audit log রাখতে হবে।
- Realtime event এলে event payload-কে চূড়ান্ত তথ্য ধরে না নিয়ে অনুমতিসহ সার্ভার থেকে পুনরায় তথ্য পড়তে হবে।

এই helper একা চালু লাইভ অ্যাপ তৈরি করে না। Supabase credentials, RLS, server-side approval, FCM এবং UI integration সম্পন্ন হলে লাইভ সিঙ্ক কার্যকর হবে।
