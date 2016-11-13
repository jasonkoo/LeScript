// ORM class for table 'statresult'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Fri Apr 24 13:31:14 PDT 2015
// For connector: org.apache.sqoop.manager.MySQLManager
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapred.lib.db.DBWritable;
import com.cloudera.sqoop.lib.JdbcWritableBridge;
import com.cloudera.sqoop.lib.DelimiterSet;
import com.cloudera.sqoop.lib.FieldFormatter;
import com.cloudera.sqoop.lib.RecordParser;
import com.cloudera.sqoop.lib.BooleanParser;
import com.cloudera.sqoop.lib.BlobRef;
import com.cloudera.sqoop.lib.ClobRef;
import com.cloudera.sqoop.lib.LargeObjectLoader;
import com.cloudera.sqoop.lib.SqoopRecord;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class statresult extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private String thekey;
  public String get_thekey() {
    return thekey;
  }
  public void set_thekey(String thekey) {
    this.thekey = thekey;
  }
  public statresult with_thekey(String thekey) {
    this.thekey = thekey;
    return this;
  }
  private String thedate;
  public String get_thedate() {
    return thedate;
  }
  public void set_thedate(String thedate) {
    this.thedate = thedate;
  }
  public statresult with_thedate(String thedate) {
    this.thedate = thedate;
    return this;
  }
  private Integer value;
  public Integer get_value() {
    return value;
  }
  public void set_value(Integer value) {
    this.value = value;
  }
  public statresult with_value(Integer value) {
    this.value = value;
    return this;
  }
  private java.sql.Timestamp lmt;
  public java.sql.Timestamp get_lmt() {
    return lmt;
  }
  public void set_lmt(java.sql.Timestamp lmt) {
    this.lmt = lmt;
  }
  public statresult with_lmt(java.sql.Timestamp lmt) {
    this.lmt = lmt;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof statresult)) {
      return false;
    }
    statresult that = (statresult) o;
    boolean equal = true;
    equal = equal && (this.thekey == null ? that.thekey == null : this.thekey.equals(that.thekey));
    equal = equal && (this.thedate == null ? that.thedate == null : this.thedate.equals(that.thedate));
    equal = equal && (this.value == null ? that.value == null : this.value.equals(that.value));
    equal = equal && (this.lmt == null ? that.lmt == null : this.lmt.equals(that.lmt));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof statresult)) {
      return false;
    }
    statresult that = (statresult) o;
    boolean equal = true;
    equal = equal && (this.thekey == null ? that.thekey == null : this.thekey.equals(that.thekey));
    equal = equal && (this.thedate == null ? that.thedate == null : this.thedate.equals(that.thedate));
    equal = equal && (this.value == null ? that.value == null : this.value.equals(that.value));
    equal = equal && (this.lmt == null ? that.lmt == null : this.lmt.equals(that.lmt));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.thekey = JdbcWritableBridge.readString(1, __dbResults);
    this.thedate = JdbcWritableBridge.readString(2, __dbResults);
    this.value = JdbcWritableBridge.readInteger(3, __dbResults);
    this.lmt = JdbcWritableBridge.readTimestamp(4, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.thekey = JdbcWritableBridge.readString(1, __dbResults);
    this.thedate = JdbcWritableBridge.readString(2, __dbResults);
    this.value = JdbcWritableBridge.readInteger(3, __dbResults);
    this.lmt = JdbcWritableBridge.readTimestamp(4, __dbResults);
  }
  public void loadLargeObjects(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void loadLargeObjects0(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void write(PreparedStatement __dbStmt) throws SQLException {
    write(__dbStmt, 0);
  }

  public int write(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeString(thekey, 1 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(thedate, 2 + __off, 1, __dbStmt);
    JdbcWritableBridge.writeInteger(value, 3 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(lmt, 4 + __off, 93, __dbStmt);
    return 4;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeString(thekey, 1 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(thedate, 2 + __off, 1, __dbStmt);
    JdbcWritableBridge.writeInteger(value, 3 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(lmt, 4 + __off, 93, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.thekey = null;
    } else {
    this.thekey = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.thedate = null;
    } else {
    this.thedate = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.value = null;
    } else {
    this.value = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lmt = null;
    } else {
    this.lmt = new Timestamp(__dataIn.readLong());
    this.lmt.setNanos(__dataIn.readInt());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.thekey) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, thekey);
    }
    if (null == this.thedate) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, thedate);
    }
    if (null == this.value) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.value);
    }
    if (null == this.lmt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.lmt.getTime());
    __dataOut.writeInt(this.lmt.getNanos());
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.thekey) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, thekey);
    }
    if (null == this.thedate) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, thedate);
    }
    if (null == this.value) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.value);
    }
    if (null == this.lmt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.lmt.getTime());
    __dataOut.writeInt(this.lmt.getNanos());
    }
  }
  private static final DelimiterSet __outputDelimiters = new DelimiterSet((char) 44, (char) 10, (char) 0, (char) 0, false);
  public String toString() {
    return toString(__outputDelimiters, true);
  }
  public String toString(DelimiterSet delimiters) {
    return toString(delimiters, true);
  }
  public String toString(boolean useRecordDelim) {
    return toString(__outputDelimiters, useRecordDelim);
  }
  public String toString(DelimiterSet delimiters, boolean useRecordDelim) {
    StringBuilder __sb = new StringBuilder();
    char fieldDelim = delimiters.getFieldsTerminatedBy();
    __sb.append(FieldFormatter.escapeAndEnclose(thekey==null?"null":thekey, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(thedate==null?"null":thedate, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(value==null?"null":"" + value, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lmt==null?"null":"" + lmt, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(thekey==null?"null":thekey, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(thedate==null?"null":thedate, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(value==null?"null":"" + value, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lmt==null?"null":"" + lmt, delimiters));
  }
  private static final DelimiterSet __inputDelimiters = new DelimiterSet((char) 1, (char) 10, (char) 0, (char) 0, false);
  private RecordParser __parser;
  public void parse(Text __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharSequence __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(byte [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(char [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(ByteBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  private void __loadFromFields(List<String> fields) {
    Iterator<String> __it = fields.listIterator();
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.thekey = null; } else {
      this.thekey = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.thedate = null; } else {
      this.thedate = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.value = null; } else {
      this.value = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lmt = null; } else {
      this.lmt = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.thekey = null; } else {
      this.thekey = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.thedate = null; } else {
      this.thedate = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.value = null; } else {
      this.value = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lmt = null; } else {
      this.lmt = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    statresult o = (statresult) super.clone();
    o.lmt = (o.lmt != null) ? (java.sql.Timestamp) o.lmt.clone() : null;
    return o;
  }

  public void clone0(statresult o) throws CloneNotSupportedException {
    o.lmt = (o.lmt != null) ? (java.sql.Timestamp) o.lmt.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("thekey", this.thekey);
    __sqoop$field_map.put("thedate", this.thedate);
    __sqoop$field_map.put("value", this.value);
    __sqoop$field_map.put("lmt", this.lmt);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("thekey", this.thekey);
    __sqoop$field_map.put("thedate", this.thedate);
    __sqoop$field_map.put("value", this.value);
    __sqoop$field_map.put("lmt", this.lmt);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("thekey".equals(__fieldName)) {
      this.thekey = (String) __fieldVal;
    }
    else    if ("thedate".equals(__fieldName)) {
      this.thedate = (String) __fieldVal;
    }
    else    if ("value".equals(__fieldName)) {
      this.value = (Integer) __fieldVal;
    }
    else    if ("lmt".equals(__fieldName)) {
      this.lmt = (java.sql.Timestamp) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("thekey".equals(__fieldName)) {
      this.thekey = (String) __fieldVal;
      return true;
    }
    else    if ("thedate".equals(__fieldName)) {
      this.thedate = (String) __fieldVal;
      return true;
    }
    else    if ("value".equals(__fieldName)) {
      this.value = (Integer) __fieldVal;
      return true;
    }
    else    if ("lmt".equals(__fieldName)) {
      this.lmt = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
