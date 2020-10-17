package com.schedule.system.oreluniver;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

class TmpNumberWeak {
    private int computed;

    public int getcomputed() {
        return computed;
    }

}

public class ScheduleConnectionStudent {
    HTTPConnection http = new HTTPConnection();


    public List<DivisionList> getDivisionList() throws Exception {
        String json = http.sendGet("http://oreluniver.ru/schedule/divisionlistforstuds");

        Type itemsListType = new TypeToken<List<DivisionList>>() {
        }.getType();
        List<DivisionList> listItemsDes = new Gson().fromJson(json, itemsListType);

        return listItemsDes;
    }

    public List<KurList> getKurList(int idDiv) throws Exception {
        String json = http.sendGet("http://oreluniver.ru/schedule/" + idDiv + "/kurslist");

        Type itemsListType = new TypeToken<List<KurList>>() {
        }.getType();
        List<KurList> listItemsDes = new Gson().fromJson(json, itemsListType);

        return listItemsDes;
    }

    public List<GroupList> getGroupList(int idDiv, int kurNum) throws Exception {
        String json = http.sendGet("http://oreluniver.ru/schedule/" + idDiv + "/" + kurNum + "/grouplist");

        Type itemsListType = new TypeToken<List<GroupList>>() {
        }.getType();
        List<GroupList> listItemsDes = new Gson().fromJson(json, itemsListType);

        return listItemsDes;
    }

    public List<ScheduleList> getShaduleList(Object groupId, long timeMill) throws Exception {
        NumberWeak tmpNumberWeak = new NumberWeak(0);

        String json = http.sendGet("http://oreluniver.ru/schedule//" + groupId + "///" + tmpNumberWeak.numberWeakMills() + "/printschedule");

        Object obj = new JSONParser().parse(json);


        List<ScheduleList> sch = new ArrayList();
        if (!json.equals("[]")) {
            Type itemsListType = new TypeToken<ScheduleList>() {
            }.getType();
            JSONObject jo = (JSONObject) obj;
            int i = 0;
            while (true) {
                Object a = jo.get(String.valueOf(i));
                if (a == null) {
                    break;
                }
                String strJSON = a.toString();
                //System.out.println(strJSON);
                ScheduleList tmp = new Gson().fromJson(strJSON, ScheduleList.class);
                sch.add(tmp);
                i++;
            }
        }
        return sch;
    }

    public NumberWeak getNumberWeak() throws Exception {
        NumberWeak tmpNumberWeak = new NumberWeak(0);
        String json = http.sendGet("http://oreluniver.ru/schedule/" + tmpNumberWeak.numberWeakMills() + "/numberweek");

        Type itemsListType = new TypeToken<List<TmpNumberWeak>>() {
        }.getType();
        List<TmpNumberWeak> tempListItemsDes = new Gson().fromJson(json, itemsListType);


        NumberWeak listItemsDes = new NumberWeak(tempListItemsDes.get(0).getcomputed());

        return listItemsDes;
    }

}
